import 'package:flutter/material.dart';
// Importa los widgets de Flutter (Material Design)

import '../app_drawer.dart';
// Importa el Drawer personalizado para la navegación lateral

class ImcPage extends StatefulWidget {
  // Widget con estado para la calculadora de IMC
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
  // Crea el estado asociado a este widget
}

class _ImcPageState extends State<ImcPage> {
  final _formKey = GlobalKey<FormState>();
  // Clave global para manejar el estado del Form

  final _pesoCtrl = TextEditingController();
  final _estaturaCtrl = TextEditingController();
  // Controladores para obtener los valores de los campos de texto

  @override
  void dispose() {
    // Método que se llama al eliminar el widget
    _pesoCtrl.dispose();
    _estaturaCtrl.dispose();
    // Libera recursos de los controladores
    super.dispose();
  }

  void _calcular() {
    // Función para calcular el IMC
    if (!_formKey.currentState!.validate()) return;
    // Valida los campos; si no pasan, se detiene

    final peso = double.parse(_pesoCtrl.text.replaceAll(',', '.'));
    final est = double.parse(_estaturaCtrl.text.replaceAll(',', '.'));
    // Convierte los valores a double, reemplazando comas por puntos

    final imc = peso / (est * est);
    // Fórmula del IMC: peso / estatura^2

    String cat;
    // Variable para categoría según IMC
    if (imc < 18.5) {
      cat = 'Peso bajo';
    } else if (imc < 25) {
      cat = 'Normal';
    } else if (imc < 30) {
      cat = 'Sobrepeso';
    } else {
      cat = 'Obesidad';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('IMC: ${imc.toStringAsFixed(1)} — $cat'))
    );
    // Muestra un SnackBar con el IMC y la categoría
  }

  void _limpiar() {
    // Función para limpiar el formulario
    _formKey.currentState!.reset();
    _pesoCtrl.clear();
    _estaturaCtrl.clear();
    // Resetea los campos y elimina errores
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estructura principal de la pantalla
      appBar: AppBar(title: const Text('Calculadora de IMC')),
      // Barra superior con título
      drawer: const AppDrawer(),
      // Drawer lateral reutilizable
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          // Asociamos el formKey al Form para validación
          child: Column(
            children: [
              TextFormField(
                controller: _pesoCtrl,
                // Controlador para peso
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                // Teclado numérico con decimal
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  prefixIcon: Icon(Icons.monitor_weight),
                  border: OutlineInputBorder()
                ),
                validator: (v) {
                  // Función de validación
                  if (v == null || v.isEmpty) return 'Obligatorio';
                  final n = double.tryParse(v.replaceAll(',', '.'));
                  if (n == null || n <= 0) return 'Número válido mayor a 0';
                  return null;
                },
                textInputAction: TextInputAction.next,
                // Botón "siguiente" en el teclado
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _estaturaCtrl,
                // Controlador para estatura
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Estatura (m)',
                  prefixIcon: Icon(Icons.height),
                  border: OutlineInputBorder()
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Obligatorio';
                  final n = double.tryParse(v.replaceAll(',', '.'));
                  if (n == null || n <= 0) return 'Número válido mayor a 0';
                  return null;
                },
                textInputAction: TextInputAction.done,
                // Botón "hecho" en el teclado
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: _calcular, child: const Text('Calcular')),
                  // Botón para calcular IMC
                  OutlinedButton(onPressed: _limpiar, child: const Text('Limpiar')),
                  // Botón para limpiar formulario
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
