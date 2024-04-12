// ignore: unused_import
import 'dart:convert';
// ignore: unnecessary_import
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http/http.dart' as http;

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  Uint8List? _imageData;

  Future<void> _pickImage() async {
    final Uint8List? imageData = await ImagePickerWeb.getImageAsBytes();
    setState(() {
      _imageData = imageData;
    });
  }

  Future<void> _agregarProducto() async {
    if (_nombreController.text.isEmpty || _cantidadController.text.isEmpty || _precioController.text.isEmpty || _imageData == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Todos los campos son obligatorios y se debe seleccionar una imagen')));
      return;
    }

    var uri = Uri.parse('http://localhost:3000/inventario/productos');
    var request = http.MultipartRequest('POST', uri)
      ..fields['nombre'] = _nombreController.text
      ..fields['precio'] = _precioController.text
      ..fields['cantidad'] = _cantidadController.text;
    if (_imageData != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'imagen',
        _imageData!,
        filename: 'uploaded_image.png', // Consider using a more descriptive file name
      ));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Producto agregado con éxito')));
      // Here you can navigate to another screen or perform other actions
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al agregar el producto: ${response.body}')));
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Confirmar"),
          content: Text("¿Desea agregar este producto?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text("Agregar"),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cerrar el diálogo
                _agregarProducto();
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
        leading: BackButton(color: Colors.white),
        title: Text('NUEVO PRODUCTO', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: DottedBorder(
                color: Colors.grey,
                strokeWidth: 2,
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                dashPattern: [10, 4],
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _imageData != null
                        ? Image.memory(_imageData!, fit: BoxFit.cover)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, color: Colors.grey, size: 40),
                              Text('Arrastrar imagen del producto', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre del producto:',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _cantidadController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Cantidad:',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _precioController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
              decoration: InputDecoration(
                labelText: 'Precio:',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => _showConfirmationDialog(context),
              child: Text('Agregar', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
   }