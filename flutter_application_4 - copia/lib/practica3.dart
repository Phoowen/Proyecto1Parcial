import 'package:flutter/material.dart';
import 'practica1.dart';
import 'practica2.dart';
import 'practica4.dart';

class Practica3 extends StatelessWidget {
  const Practica3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menú de Prácticas")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Practica1()),
                );
              },
              child: const Text("Ir a Práctica 1"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Practica2()),
                );
              },
              child: const Text("Ir a Práctica 2"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Practica4()),
                );
              },
              child: const Text("Ir a Práctica 4"),
            ),
          ],
        ),
      ),
    );
  }
}
