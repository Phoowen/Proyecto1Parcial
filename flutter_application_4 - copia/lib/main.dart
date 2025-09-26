import 'package:flutter/material.dart';
// Importa la librería principal de Flutter con todos los widgets de Material Design

import 'hub.dart';
import 'practices_index.dart';
import 'practica1.dart';
import 'practica2.dart';
import 'practica3.dart';
import 'practica4.dart';
import 'practica5.dart';
import 'kit_offline/kit_offline.dart';
import 'kit_offline/notas.dart';
import 'kit_offline/imc.dart';
import 'kit_offline/gallery.dart';
import 'kit_offline/par_impar.dart';
import 'settings.dart';
// Importa todas las pantallas de la app: Hub, prácticas, proyecto Kit Offline y ajustes

/// Notifier global para el ThemeMode (estado en memoria)
final ValueNotifier<ThemeMode> appTheme = ValueNotifier(ThemeMode.light);
// Crea un ValueNotifier para manejar el tema claro/oscuro de la app
// Esto permite cambiar el ThemeMode en tiempo real desde cualquier pantalla

void main() {
  runApp(const MyApp());
  // Punto de entrada de la app
  // Ejecuta el widget MyApp
}

class MyApp extends StatelessWidget {
  // Widget principal de la app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Construye la UI de la app
    return ValueListenableBuilder<ThemeMode>(
      // Escucha cambios en el ValueNotifier appTheme
      valueListenable: appTheme,
      builder: (context, mode, _) {
        // Se reconstruye cada vez que cambia el ThemeMode
        return MaterialApp(
          title: 'Kit Offline',
          // Título de la app
          theme: ThemeData.light(),
          // Tema claro
          darkTheme: ThemeData.dark(),
          // Tema oscuro
          themeMode: mode,
          // Aplica el ThemeMode actual (claro u oscuro)
          debugShowCheckedModeBanner: false,
          // Oculta el banner de DEBUG
          initialRoute: '/',
          // Ruta inicial al arrancar la app
          routes: {
            // Diccionario de rutas nombradas
            '/': (context) => const Hub(),
            // Pantalla principal (Hub)
            '/practices': (context) => const PracticesIndex(),
            // Pantalla con índice de prácticas
            '/p1': (context) => const Practica1(),
            '/p2': (context) => const Practica2(),
            '/p3': (context) => const Practica3(),
            '/p4': (context) => const Practica4(),
            '/p5': (context) => const Practica5(),
            // Rutas de prácticas individuales
            '/project': (context) => const KitOffline(),
            '/project/notas': (context) => const NotasPage(),
            '/project/imc': (context) => const ImcPage(),
            '/project/gallery': (context) => const GalleryPage(),
            '/project/par_impar': (context) => const ParImparPage(),
            // Rutas del proyecto "Kit Offline" y sus módulos
            '/settings': (context) => const SettingsPage(),
            // Pantalla de ajustes y acerca de
          },
        );
      },
    );
  }
}
