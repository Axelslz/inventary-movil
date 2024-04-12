// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PasswordResetScreen extends StatelessWidget {
  final TextEditingController _emailPhoneController = TextEditingController();

  Future<void> sendPasswordResetCode(BuildContext context, String email) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/reset-password'), // Cambia a la URL de tu API
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      // Si el servidor devuelve una respuesta OK, mostramos un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Revisa tu correo electrónico para el código de restablecimiento')),
      );
    } else {
      // Si el servidor no devuelve una respuesta OK, mostramos un error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar el código de restablecimiento')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Color de fondo para toda la pantalla
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(), // Regresa a la pantalla anterior
        ),
        backgroundColor: Colors.transparent, // Hace que AppBar sea transparente
        elevation: 0, // Elimina la sombra de la AppBar
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'RESTABLECER CONTRASEÑA',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Introduce un método de recuperación y te enviaremos un código para restablecer tu contraseña',
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailPhoneController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico o Teléfono',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_emailPhoneController.text.isNotEmpty) {
                    sendPasswordResetCode(context, _emailPhoneController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green, // foreground (text) color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Enviar'),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

