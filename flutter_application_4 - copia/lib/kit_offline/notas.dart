import 'package:flutter/material.dart';
// Importa la librería principal de Flutter con widgets de Material Design

import '../app_drawer.dart';
// Importa el Drawer lateral personalizado que se reutiliza en toda la app

// ---------------------------
// Widget principal de Notas
// ---------------------------
class NotasPage extends StatefulWidget {
  // StatefulWidget porque necesitamos mantener la lista de notas en memoria
  const NotasPage({super.key});

  @override
  State<NotasPage> createState() => _NotasPageState();
  // Crea el estado asociado a este widget
}

// ---------------------------
// Estado de NotasPage
// ---------------------------
class _NotasPageState extends State<NotasPage> {
  final List<String> _notas = [];
  // Lista en memoria que guarda todas las notas agregadas por el usuario

  // ---------------------------
  // Función para agregar una nueva nota
  // ---------------------------
  void _agregarNota() async {
    final controlador = TextEditingController();
    // Controlador para capturar el texto del TextField dentro del diálogo

    // Mostramos un diálogo para escribir la nueva nota
    final result = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Nueva nota'),
          // Título del diálogo
          content: TextField(
            controller: controlador,
            maxLength: 120,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Escribe algo corto'),
          ),
          // Campo de texto para ingresar la nota
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            // Botón para cerrar el diálogo sin agregar la nota
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controlador.text.trim()),
              child: const Text('Agregar'),
            ),
            // Botón que devuelve el texto ingresado y cierra el diálogo
          ],
        );
      },
    );

    // Si se ingresó un texto válido, lo agregamos a la lista
    if (result != null && result.isNotEmpty) {
      setState(() => _notas.insert(0, result));
      // Insertamos la nota al inicio de la lista y actualizamos la UI
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Nota agregada')),
      );
      // Mensaje de confirmación al usuario
    }
  }

  // ---------------------------
  // Función para borrar todas las notas
  // ---------------------------
  void _borrarTodo() {
    if (_notas.isEmpty) return;
    // Si la lista está vacía, no hacemos nada
    setState(() => _notas.clear());
    // Limpiamos la lista y actualizamos la UI
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Todas las notas borradas')),
    );
    // Mensaje de confirmación
  }

  // ---------------------------
  // Construcción de la interfaz
  // ---------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas rápidas'),
        actions: [
          IconButton(
            onPressed: _borrarTodo,
            icon: const Icon(Icons.delete_forever),
          ),
          // Botón en AppBar para borrar todas las notas de la lista
        ],
      ),
      drawer: const AppDrawer(),
      // Drawer lateral reutilizable con navegación a otras pantallas
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarNota,
        child: const Icon(Icons.add),
        // Botón flotante para agregar una nueva nota
      ),
      body: _notas.isEmpty
          ? const Center(
              child: Text('No hay notas. Presiona + para agregar.'),
            )
          // Mensaje cuando no hay notas
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _notas.length,
              // Construye la lista según el número de notas
              itemBuilder: (context, i) {
                final n = _notas[i];
                return Card(
                  child: ListTile(
                    title: Text(n),
                    // Muestra el contenido de la nota
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() => _notas.removeAt(i));
                        // Elimina la nota específica y actualiza la UI
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Nota eliminada')),
                        );
                        // Mensaje de confirmación
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
