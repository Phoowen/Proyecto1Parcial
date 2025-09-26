import 'package:flutter/material.dart'; 

class AppDrawer extends StatelessWidget {

  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    Widget nav(String route, String title, IconData icon) {
 
      return ListTile(
        leading: Icon(icon), 
        title: Text(title), 
        onTap: () {
          Navigator.pop(context); 
          Navigator.pushNamed(context, route); 
        },
      );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, 
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 41, 97, 143)), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: const [
                Text(
                  'Kit Offline', 
                  style: TextStyle(color: Colors.white, fontSize: 20)
                ),
                SizedBox(height: 8), 
                Text(
                  'Portafolio / Proyecto', 
                  style: TextStyle(color: Colors.white70)
                ),
              ],
            ),
          ),
          nav('/', 'Inicio (Hub)', Icons.home),
          nav('/practices', 'Prácticas (P1…Pn)', Icons.list),
          nav('/project', 'Proyecto: Kit Offline', Icons.build_circle),
          nav('/settings', 'Ajustes / Acerca de', Icons.settings),
        ],
      ),
    );
  }
}
