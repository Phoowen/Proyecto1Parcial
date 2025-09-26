import 'package:flutter/material.dart';
import 'app_drawer.dart';

class PracticesIndex extends StatelessWidget {
  const PracticesIndex({super.key});

  @override
  Widget build(BuildContext context) {

    final items = [
      {'title': 'Práctica 1 - Hola Mundo', 'route': '/p1'},
      {'title': 'Práctica 2 - Botón 10 Hola Mundo', 'route': '/p2'},
      {'title': 'Práctica 3 - Menú', 'route': '/p3'},
      {'title': 'Práctica 4 - Form Registro', 'route': '/p4'},
      {'title': 'Práctica 5 - Drawer + RPS', 'route': '/p5'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Prácticas')),
      drawer: const AppDrawer(),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, i) {
          final it = items[i];
          return ListTile(
            leading: CircleAvatar(child: Text('P${i+1}')),
            title: Text(it['title']!),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, it['route']!),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: items.length,
      ),
    );
  }
}
