import 'package:flutter/material.dart';

class Practica2 extends StatefulWidget {
  const Practica2({super.key});

  @override
  State<Practica2> createState() => _Practica2State();
}

class _Practica2State extends State<Practica2> {
  bool _mostrarTextos = false;
  static const int _numeroTextos = 10;

  void _toggleTextos() {
    setState(() {
      _mostrarTextos = !_mostrarTextos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Práctica 2")),
      body: Practice2Content(
        mostrarTextos: _mostrarTextos,
        onToggleTextos: _toggleTextos,
      ),
    );
  }
}

class Practice2Content extends StatelessWidget {
  final bool mostrarTextos;
  final VoidCallback onToggleTextos;

  const Practice2Content({
    super.key,
    required this.mostrarTextos,
    required this.onToggleTextos,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToggleButton(onPressed: onToggleTextos),
          const SizedBox(height: 20),
          if (mostrarTextos) const TextList(),
          const SizedBox(height: 20),
          const BackButton(),
        ],
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ToggleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text("Clic"),
    );
  }
}

class TextList extends StatelessWidget {
  const TextList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        _Practica2State._numeroTextos,
        (index) => const Text(
          "Hola Mundo",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}