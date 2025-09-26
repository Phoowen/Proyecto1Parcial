import 'dart:math';
import 'package:flutter/material.dart';
import '../app_drawer.dart';

class ParImparPage extends StatefulWidget {
  const ParImparPage({super.key});

  @override
  State<ParImparPage> createState() => _ParImparPageState();
}


class _ParImparPageState extends State<ParImparPage> {
  final Random _rnd = Random();
  int _puntosUsuario = 0;
  int _puntosCPU = 0;

  void _jugar(bool elegirPar, int numeroUsuario) {
    final cpu = _rnd.nextInt(6); 
    final suma = cpu + numeroUsuario; 
    final esPar = suma % 2 == 0; 
    final usuarioGana = (esPar && elegirPar) || (!esPar && !elegirPar);
    
    final mensaje =
        'Tu: $numeroUsuario — CPU: $cpu → Suma $suma (${esPar ? 'Par' : 'Impar'}) — ${usuarioGana ? 'Ganaste' : 'Perdiste'}';

    if (usuarioGana)
      _puntosUsuario++;
    else
      _puntosCPU++;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));

    setState(() {});
  }

  void _reiniciar() {
    setState(() {
      _puntosUsuario = 0;
      _puntosCPU = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego — Par o Impar'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              'Elige Par o Impar y luego un número (0–5)',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  child: const Text('Par'),
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Impar')),
              ],
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(6, (i) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('¿Par o Impar con número $i?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _jugar(true, i); 
                              },
                              child: const Text('Par'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _jugar(false, i); 
                              },
                              child: const Text('Impar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('$i'),
                );
              }),
            ),
            const SizedBox(height: 16),

            Text(
              'Marcador: Usuario $_puntosUsuario — CPU $_puntosCPU',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: _reiniciar,
              child: const Text('Reiniciar marcador'),
            ),
          ],
        ),
      ),
    );
  }
}
