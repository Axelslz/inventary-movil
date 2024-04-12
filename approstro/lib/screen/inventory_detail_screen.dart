// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InventoryDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  InventoryDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _InventoryDetailScreenState createState() => _InventoryDetailScreenState();
}

class _InventoryDetailScreenState extends State<InventoryDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late int _quantity; // Cantidad a modificar

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['nombre']);
    _priceController = TextEditingController(text: widget.product['precio'].toString());
    _quantity = widget.product['cantidad']; // Inicializar con la cantidad actual
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  Future<void> _saveChanges() async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/inventario/productos/${widget.product['id']}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nombre': _nameController.text,
        'precio': _priceController.text,
        'cantidad': _quantity, // Envía la nueva cantidad
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Producto actualizado con éxito')));
      Navigator.pop(context, true); // Puedes pasar un valor booleano para indicar que la operación fue exitosa
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al actualizar el producto')));
    }
  }

  Future<void> _deleteProduct() async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/inventario/productos/${widget.product['id']}'),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Producto eliminado con éxito')));
      Navigator.pop(context); // Regresa a la pantalla anterior
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al eliminar el producto')));
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Estás seguro de que deseas eliminar este producto?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text("Eliminar"),
              onPressed: () {
                _deleteProduct();
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _showDeleteDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre del Producto'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementQuantity,
                ),
                Text('$_quantity'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementQuantity,
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}


