// ignore_for_file: prefer_const_constructors

import 'package:approstro/screen/inventory_management_screen.dart';
import 'package:flutter/material.dart';
// Asegúrate de que este archivo exista y tenga una clase InventoryDetailScreen
import 'stock_screen.dart'; // Asegúrate de que este archivo exista y tenga una clase StockScreen

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red, // Color de fondo del AppBar
        title: Text('INICIO', style: TextStyle(color: Colors.white)), // Color del texto del título
        centerTitle: true, // Centra el título
        leading: PopupMenuButton<String>(
          onSelected: (String result) {
            // Implementa las acciones al seleccionar los ítems aquí
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'profile',
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Cuenta'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Salir de cuenta'),
              ),
            ),
            // Añade más ítems aquí si es necesario
          ],
          icon: Icon(Icons.account_circle, color: Colors.white), // Color del ícono del usuario
        ),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.white), // Color del ícono del menú
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Abre el Drawer
                },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Agrega elementos al menú aquí
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text('Inventario'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => InventoryManagementScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Ventas'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => StockScreen()));
              },
            ),
            // ... Agrega más elementos si lo necesitas
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600), // Establece un ancho máximo para los elementos centrales
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ChoiceCard(
            choice: Choice(title: 'Inventario', icon: Icons.inventory),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => InventoryManagementScreen()));
            },
          ),
          ChoiceCard(
            choice: Choice(title: 'Ventas', icon: Icons.shopping_cart),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => StockScreen()));
            },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key? key, required this.choice, required this.onTap}) : super(key: key);
  final Choice choice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(choice.icon, size: 80.0, color: Colors.orange),
              Text(choice.title, style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}
