import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockScreen extends StatefulWidget {
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  List<dynamic> _salesHistory = []; // Almacenará el historial de ventas
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSalesHistory();
  }

  Future<void> _fetchSalesHistory() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/inventario/ventas'));
      if (response.statusCode == 200) {
        final List<dynamic> salesData = json.decode(response.body);
        setState(() {
          _salesHistory = salesData;
        });
      } else {
        _showErrorSnackbar('Error al obtener el historial de ventas: ${response.body}');
      }
    } catch (e) {
      _showErrorSnackbar('Error al conectar con el servidor: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Ventas'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchSalesHistory,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: _salesHistory.length,
            itemBuilder: (context, index) {
              final sale = _salesHistory[index];
              return ListTile(
                title: Text('Producto ID: ${sale['idProducto']}'),
                subtitle: Text('Cantidad vendida: ${sale['cantidad']}'),
                trailing: Text('Fecha: ${sale['fechaVenta']}'),
              );
            },
          ),
    );
  }
}

