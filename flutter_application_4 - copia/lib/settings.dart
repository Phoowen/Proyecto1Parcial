import 'package:flutter/material.dart';
// Importa la librería principal de Flutter con widgets de Material Design

import 'main.dart' show appTheme;
// Importa solo el ValueNotifier global appTheme desde main.dart
// Este notifier controla el ThemeMode (claro/oscuro) en toda la app

import 'app_drawer.dart';
// Importa el Drawer personalizado que ya creamos

class SettingsPage extends StatelessWidget {
  // Widget inmutable para la pantalla de ajustes
  const SettingsPage({super.key});
  // Constructor constante

  @override
  Widget build(BuildContext context) {
    // Método que construye la UI del widget
    return Scaffold(
      // Estructura principal de la pantalla
      appBar: AppBar(title: const Text('Ajustes')),
      // Barra superior con título
      drawer: const AppDrawer(),
      // Drawer lateral reutilizable
      body: ListView(
        // Lista desplazable verticalmente
        children: [
          ValueListenableBuilder<ThemeMode>(
            // Escucha los cambios del notifier appTheme
            valueListenable: appTheme,
            builder: (context, mode, _) {
              // Se reconstruye cuando cambia el ThemeMode
              return SwitchListTile(
                // ListTile con un switch para alternar tema
                title: const Text('Tema oscuro'),
                subtitle: const Text('Alternar tema claro / oscuro'),
                value: mode == ThemeMode.dark,
                // El switch está activado si el tema es oscuro
                onChanged: (v) =>
                    appTheme.value = v ? ThemeMode.dark : ThemeMode.light,
                // Al cambiar, actualiza el ThemeMode global
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            // Icono de información al inicio
            title: const Text('Acerca de'),
            subtitle: const Text('v1.0 — Autor: Zárate Owen'),
            // Título y subtítulo de la sección
            onTap: () {
              // Acción al presionar: mostrar diálogo de "Acerca de"
              showAboutDialog(
                context: context,
                applicationName: 'Kit Offline',
                applicationVersion: '1.0',
                applicationLegalese:
                    'Hecho sin persistencia — estado en memoria',
                // Información legal / descripción
              );
            },
          ),
        ],
      ),
    );
  }
}
