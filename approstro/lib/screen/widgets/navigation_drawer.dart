import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Usuario"),
            accountEmail: Text("usuario@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                "U",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/'); // Asegúrate de definir las rutas en main.dart
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Inventario'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/inventory');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Ventas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sales');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: () {
              // Implementar la lógica de cerrar sesión
            },
          ),
        ],
      ),
    );
  }
}