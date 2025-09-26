import 'package:flutter/material.dart';
import '../app_drawer.dart';

class KitOffline extends StatelessWidget {
  const KitOffline({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kit Offline - Proyecto'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: isWeb ? null : const AppDrawer(),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWeb ? 40.0 : 16.0, 
            vertical: 24
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: const _ProjectContent(),
          ),
        ),
      ),
    );
  }
}

class _ProjectContent extends StatelessWidget {
  const _ProjectContent();

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'Módulos del Proyecto'),
        const SizedBox(height: 8),
        Text(
          'Suite de herramientas offline integradas',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: _ModulesGrid(isWeb: isWeb),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

class _ModulesGrid extends StatelessWidget {
  final bool isWeb;

  const _ModulesGrid({required this.isWeb});

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = isWeb ? 2 : 1;
    final double childAspectRatio = isWeb ? 1.8 : 1.5;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: childAspectRatio,
      children: const [
        _ModuleCard(
          title: 'Notas Rápidas',
          subtitle: 'Sistema de creación y gestión de notas en memoria',
          icon: Icons.note_alt,
          route: '/project/notas',
          color: Colors.green,
        ),
        _ModuleCard(
          title: 'Calculadora de IMC',
          subtitle: 'Calculadora de Índice de Masa Corporal con validación',
          icon: Icons.monitor_weight,
          route: '/project/imc',
          color: Colors.orange,
        ),
        _ModuleCard(
          title: 'Galería Local',
          subtitle: 'Explorador de imágenes desde assets de la aplicación',
          icon: Icons.photo_library,
          route: '/project/gallery',
          color: Colors.blue,
        ),
        _ModuleCard(
          title: 'Par o Impar',
          subtitle: 'Juego interactivo contra la aplicación',
          icon: Icons.casino,
          route: '/project/par_impar',
          color: Colors.purple,
        ),
      ],
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final Color color;

  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, size: 32, color: color),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}