import 'package:flutter/material.dart';
import 'screen/login_screen.dart';
import 'screen/password_reset_screen.dart';
import 'screen/verification_code_screen.dart';
import 'screen/new_password_screen.dart';
import 'screen/main_screen.dart';
import 'screen/inventory_detail_screen.dart';
import 'screen/inventory_management_screen.dart';
import 'screen/stock_screen.dart'; // Asegúrate de importar la pantalla de stock

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Inventario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/password-reset': (context) => PasswordResetScreen(),
        '/verification-code': (context) => VerificationCodeScreen(),
        '/new-password': (context) => NewPasswordScreen(),
        '/main': (context) => MainScreen(),
        '/inventory-detail': (context) => InventoryDetailScreen(product: {},),
        '/inventory-management': (context) => InventoryManagementScreen(),
        '/stock': (context) => StockScreen(), 
      },
    );
  }
}