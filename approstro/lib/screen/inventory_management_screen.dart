// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Importa el paquete para trabajar con JSON
import 'inventory_detail_screen.dart';
import 'add_product_screen.dart';

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({super.key});

  @override
  _InventoryManagementScreenState createState() => _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen> {
  List<Map<String, dynamic>> products = []; // Lista para almacenar los productos

  @override
  void initState() {
    print("object");
    super.initState();
    fetchProducts(); // Llama a la función para obtener los productos cuando se inicia la pantalla
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/inventario/productos'));
      if (response.statusCode == 200) {
        final List<dynamic> productList = json.decode(response.body);
        setState(() {
          products = List<Map<String, dynamic>>.from(productList);
        });
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching products: $error');
      throw Exception('Error fetching products: $error');
    }
  }

  @override
  void didChangeDependencies() {
  super.didChangeDependencies();
  fetchProducts(); // Esto recargará los productos cuando regreses a esta pantalla.
}
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'INVENTARIO',
        style: TextStyle(color: Colors.white), // Establecer el color del texto del título aquí
      ),
      backgroundColor: Colors.red, // Cambiar el color de fondo de la AppBar a rojo
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == 'Agregar') {
              // Navegar a AddProductScreen cuando se selecciona 'Agregar'
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductScreen()),
              );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Agregar',
              child: ListTile(
                leading: Icon(Icons.add, color: Colors.white), // Cambiar el color aquí a blanco
                title: Text('Agregar producto'),
              ),
            ),
          ],
          icon: Icon(Icons.add, color: Colors.white), // Establecer el color del ícono aquí a blanco
          color: Colors.grey, // Color de fondo del menú desplegable en gris
        ),
      ],
    ),
   body: Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded( // Hacer que la imagen se expanda para llenar el espacio disponible.
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/${product['imagen']}'), // Usando la ruta de imagen de los datos del producto
                            fit: BoxFit.contain, // Esto hará que la imagen se ajuste al espacio disponible.
                          ),
                        ),
                      ),
                    ),
                    Text('Nombre: ${product['nombre']}'),
                    Text('Cantidad: ${product['cantidad']}'),
                    Text('Precio: ${product['precio']}'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), backgroundColor: Colors.green, // Color de fondo del botón
                      ),
                      child: Icon(Icons.edit, color: Colors.white), // Usar ícono de editar en lugar de texto.
                      onPressed: () {
                        // Navega a la pantalla inventory_detail.dart con la información del producto.
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InventoryDetailScreen(product: product)),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
}
  



