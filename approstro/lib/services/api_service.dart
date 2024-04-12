import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String _baseUrl = "http://localhost:3000";

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Suponiendo que la API devuelve un campo 'success' para indicar el éxito
      return data['success'];
    } else {
      // Manejo de errores o respuesta inesperada
      throw Exception('Falló el inicio de sesión');
    }
  }
  
  Future<bool> updateProduct(int id, String nombre, double precio, int cantidad) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/productos/$id'), // Asegúrate de que la ruta coincide con tu API
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nombre': nombre,
        'precio': precio,
        'cantidad': cantidad,
      }),
    );

    if (response.statusCode == 200) {
      // Puedes adaptar la respuesta según lo que tu API regrese
      return true; // Suponiendo que la actualización fue exitosa
    } else {
      print('Failed to update product: ${response.body}');
      return false; // Manejo del caso de error
    }
  }

}