import 'package:flutter/material.dart';

class Practica1 extends StatelessWidget {
  const Practica1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Práctica 1"),
      ),
      body: const Practice1Content(),
    );
  }
}

class Practice1Content extends StatelessWidget {
  const Practice1Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Practice1Text(),
          SizedBox(height: 20),
          BackButton(),
        ],
      ),
    );
  }
}

class Practice1Text extends StatelessWidget {
  const Practice1Text({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '¡Hola Mundo!',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: const Text("Volver al Menú"),
    );
  }
}