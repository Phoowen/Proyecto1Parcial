import 'dart:math';
import 'package:flutter/material.dart';
import 'practica1.dart';
import 'practica2.dart';
import 'practica3.dart';
import 'practica4.dart';
import 'hub.dart';

class Practica5 extends StatefulWidget {
  const Practica5({super.key});

  @override
  State<Practica5> createState() => _Practica5State();
}

class _Practica5State extends State<Practica5> {
  static const List<String> _opciones = ["Piedra", "Papel", "Tijera"];
  String _eleccionUsuario = "";
  String _eleccionApp = "";
  String _resultado = "";
  int _puntosUsuario = 0;
  int _puntosApp = 0;

  void _jugar(String usuario) {
    final random = Random();
    final app = _opciones[random.nextInt(_opciones.length)];

    setState(() {
      _eleccionUsuario = usuario;
      _eleccionApp = app;
      _resultado = _calcularResultado(usuario, app);
    });
  }

  String _calcularResultado(String usuario, String app) {
    if (usuario == app) return "Empate";
    
    final reglasGanadoras = {
      "Piedra": "Tijera",
      "Papel": "Piedra", 
      "Tijera": "Papel",
    };

    if (reglasGanadoras[usuario] == app) {
      _puntosUsuario++;
      return "¡Ganaste!";
    } else {
      _puntosApp++;
      return "Perdiste";
    }
  }

  void _reiniciar() {
    setState(() {
      _eleccionUsuario = "";
      _eleccionApp = "";
      _resultado = "";
      _puntosUsuario = 0;
      _puntosApp = 0;
    });
  }

  void _volverAlHub(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Hub()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Práctica 5 - Piedra, Papel o Tijera"),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        elevation: 0,
        leading: isWeb ? null : IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      drawer: isWeb ? null : _buildDrawer(context),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWeb ? 40.0 : 16.0,
            vertical: 24,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: _buildBody(context, isWeb),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          _buildDrawerItem(
            icon: Icons.home,
            title: "Hub Principal",
            onTap: () => _volverAlHub(context),
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.code,
            title: "Práctica 1",
            onTap: () => _navigateTo(context, const Practica1()),
          ),
          _buildDrawerItem(
            icon: Icons.code,
            title: "Práctica 2", 
            onTap: () => _navigateTo(context, const Practica2()),
          ),
          _buildDrawerItem(
            icon: Icons.code,
            title: "Práctica 3",
            onTap: () => _navigateTo(context, const Practica3()),
          ),
          _buildDrawerItem(
            icon: Icons.code,
            title: "Práctica 4",
            onTap: () => _navigateTo(context, const Practica4()),
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.sports_esports,
            title: "Piedra, Papel o Tijera",
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget _buildBody(BuildContext context, bool isWeb) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _GameHeader(),
        const SizedBox(height: 32),
        _GameButtons(onJugar: _jugar, isWeb: isWeb),
        if (_eleccionUsuario.isNotEmpty) ...[
          const SizedBox(height: 32),
          _GameResults(
            eleccionUsuario: _eleccionUsuario,
            eleccionApp: _eleccionApp,
            resultado: _resultado,
            puntosUsuario: _puntosUsuario,
            puntosApp: _puntosApp,
          ),
          const SizedBox(height: 24),
          _ResetButton(onReiniciar: _reiniciar),
        ],
        const SizedBox(height: 32),
        _ActionButtons(onVolver: () => _volverAlHub(context)),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[900],
      ),
      child: const Center(
        child: Text(
          "Navegación",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _GameHeader extends StatelessWidget {
  const _GameHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.sports_esports, size: 64, color: Colors.blue.shade600),
        const SizedBox(height: 16),
        const Text(
          "Piedra, Papel o Tijera",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Elige tu jugada para comenzar",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _GameButtons extends StatelessWidget {
  final Function(String) onJugar;
  final bool isWeb;

  const _GameButtons({required this.onJugar, required this.isWeb});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: isWeb ? 20 : 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: _Practica5State._opciones.map((opcion) {
        return _GameButton(
          opcion: opcion,
          onPressed: () => onJugar(opcion),
        );
      }).toList(),
    );
  }
}

class _GameButton extends StatelessWidget {
  final String opcion;
  final VoidCallback onPressed;

  const _GameButton({required this.opcion, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (opcion) {
      case "Piedra":
        icon = Icons.landscape;
        break;
      case "Papel":
        icon = Icons.description;
        break;
      case "Tijera":
        icon = Icons.content_cut;
        break;
      default:
        icon = Icons.question_mark;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.blue.shade600),
              const SizedBox(height: 8),
              Text(
                opcion,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GameResults extends StatelessWidget {
  final String eleccionUsuario;
  final String eleccionApp;
  final String resultado;
  final int puntosUsuario;
  final int puntosApp;

  const _GameResults({
    required this.eleccionUsuario,
    required this.eleccionApp,
    required this.resultado,
    required this.puntosUsuario,
    required this.puntosApp,
  });

  @override
  Widget build(BuildContext context) {
    Color resultadoColor;
    switch (resultado) {
      case "¡Ganaste!":
        resultadoColor = Colors.green.shade600;
        break;
      case "Perdiste":
        resultadoColor = Colors.red.shade600;
        break;
      default:
        resultadoColor = Colors.orange.shade600;
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ResultItem(
                  label: "Tu elección",
                  value: eleccionUsuario,
                  icon: Icons.person,
                ),
                _ResultItem(
                  label: "App eligió",
                  value: eleccionApp,
                  icon: Icons.smartphone,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: resultadoColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: resultadoColor.withOpacity(0.3)),
              ),
              child: Text(
                resultado,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: resultadoColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Marcador Actual",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$puntosUsuario - $puntosApp",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _ResultItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.grey.shade600),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ResetButton extends StatelessWidget {
  final VoidCallback onReiniciar;

  const _ResetButton({required this.onReiniciar});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onReiniciar,
      icon: const Icon(Icons.refresh, size: 16),
      label: const Text("Reiniciar Marcador"),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey.shade700,
        side: BorderSide(color: Colors.grey.shade400),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final VoidCallback onVolver;

  const _ActionButtons({required this.onVolver});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: onVolver,
          icon: const Icon(Icons.home, size: 16),
          label: const Text("Volver al Hub"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}