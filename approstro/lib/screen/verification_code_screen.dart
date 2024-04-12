import 'package:flutter/material.dart';

class VerificationCodeScreen extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Código de Verificación'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Ingresa tu código',
                prefixIcon: Icon(Icons.lock_open),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí iría la lógica para verificar el código
              },
              child: Text('Verificar Código'),
            ),
          ],
        ),
      ),
    );
  }
}