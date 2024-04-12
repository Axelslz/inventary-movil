import 'package:approstro/services/api_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              // Tu logo o imagen de avatar aquí, ajusta según la imagen que quieras usar.
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.amber, width: 2),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8), // Espacio entre el borde y la imagen/contenido del avatar.
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent, // Sin color de fondo
                    radius: 40, // Ajusta el tamaño según tu necesidad
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.amber, // Icon color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Campos de texto
              _buildTextField(
                controller: _usernameController,
                labelText: 'Usuario',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Contraseña',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              // Botón de olvidaste tu contraseña
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/password-reset');
                  },
                  child: const Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Botón de Ingresar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Color de fondo del botón
                  shape: const StadiumBorder(), // Borde redondeado del botón
                  minimumSize: const Size(double.infinity, 36), // Anchura completa
                ),
                onPressed: () async {
                  // Aquí reinseramos la lógica de inicio de sesión
                  try {
                    final apiService = ApiService();
                    final success = await apiService.login(
                      _usernameController.text,
                      _passwordController.text,
                    );

                    if (success) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, '/main');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuario o contraseña incorrecta')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al iniciar sesión: $e')),
                    );
                  }
                },
                child: const Text('Ingresar'),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey), // Icon color
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
      ),
    );
  }
}



