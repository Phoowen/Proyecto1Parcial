import 'package:flutter/material.dart';
import 'app_drawer.dart';

class Hub extends StatelessWidget {
  const Hub({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kit Offline Hub'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: isWeb ? null : const AppDrawer(),
      body: const _HubBody(),
    );
  }
}

class _HubBody extends StatelessWidget {
  const _HubBody();

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;
    final double horizontalPadding = isWeb ? 40.0 : 16.0;

    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: _buildResponsiveLayout(isWeb),
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(bool isWeb) {
    if (isWeb) {
      return const _WebLayout();
    } else {
      return const _MobileLayout();
    }
  }
}

class _WebLayout extends StatelessWidget {
  const _WebLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sidebar para prácticas con scroll
        Container(
          width: 280,
          margin: const EdgeInsets.only(right: 24),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(title: 'Prácticas'),
              SizedBox(height: 16),
              Expanded(child: _PracticesScrollSection()), // 👈 Cambio aquí
            ],
          ),
        ),
        
        // Contenido principal
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(title: 'Dashboard Principal'),
              const SizedBox(height: 24),
              const Expanded(child: _MainCardsSection()),
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: 'Dashboard'),
        SizedBox(height: 24),
        _FeaturedPracticesSection(),
        SizedBox(height: 32),
        Expanded(child: _MainCardsSection()),
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
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

class _FeaturedPracticesSection extends StatelessWidget {
  const _FeaturedPracticesSection();

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;
    final int crossAxisCount = isWeb ? 5 : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SubSectionHeader(title: 'Acceso Rápido'),
        const SizedBox(height: 16),
        _PracticesGrid(crossAxisCount: crossAxisCount),
      ],
    );
  }
}

// 👈 NUEVA CLASE PARA LA SECCIÓN CON SCROLL
class _PracticesScrollSection extends StatelessWidget {
  const _PracticesScrollSection();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _PracticeListTile(
            route: '/p1',
            icon: Icons.code,
            label: 'Práctica 1',
            subtitle: 'Interfaz básica y navegación',
          ),
          _PracticeListTile(
            route: '/p2',
            icon: Icons.code,
            label: 'Práctica 2',
            subtitle: 'Estado y interactividad',
          ),
          _PracticeListTile(
            route: '/p3',
            icon: Icons.code,
            label: 'Práctica 3',
            subtitle: 'Formularios y validación',
          ),
          _PracticeListTile(
            route: '/p4',
            icon: Icons.code,
            label: 'Práctica 4',
            subtitle: 'Navegación avanzada',
          ),
          _PracticeListTile(
            route: '/p5',
            icon: Icons.sports_esports,
            label: 'Práctica 5',
            subtitle: 'Juego Piedra, Papel o Tijera',
          ),
        ],
      ),
    );
  }
}

// 👈 NUEVA CLASE PARA LOS ITEMS DE LISTA
class _PracticeListTile extends StatelessWidget {
  final String route;
  final IconData icon;
  final String label;
  final String subtitle;

  const _PracticeListTile({
    required this.route,
    required this.icon,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 20, color: Colors.blue.shade600),
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade500),
        onTap: () => Navigator.pushNamed(context, route),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}

class _SubSectionHeader extends StatelessWidget {
  final String title;

  const _SubSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    );
  }
}

class _PracticesGrid extends StatelessWidget {
  final int crossAxisCount;

  const _PracticesGrid({required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.9,
      children: const [
        _PracticeButton(route: '/p1', icon: Icons.code, label: 'Práctica 1'),
        _PracticeButton(route: '/p2', icon: Icons.code, label: 'Práctica 2'),
        _PracticeButton(route: '/p3', icon: Icons.code, label: 'Práctica 3'),
        _PracticeButton(route: '/p4', icon: Icons.code, label: 'Práctica 4'),
        _PracticeButton(route: '/p5', icon: Icons.sports_esports, label: 'Práctica 5'),
      ],
    );
  }
}

class _PracticeButton extends StatelessWidget {
  final String route;
  final IconData icon;
  final String label;

  const _PracticeButton({
    required this.route,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.blue.shade600),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
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

class _MainCardsSection extends StatelessWidget {
  const _MainCardsSection();

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;

    return ListView(
      children: [
        _HubCard(
          title: 'Índice de Prácticas',
          subtitle: 'Accede al listado completo de prácticas disponibles',
          icon: Icons.assignment,
          route: '/practices',
          isWeb: isWeb,
        ),
        const SizedBox(height: 16),
        _HubCard(
          title: 'Kit Offline',
          subtitle: 'Suite de herramientas: Notas, IMC, Galería, Par/Impar',
          icon: Icons.apps,
          route: '/project',
          isWeb: isWeb,
        ),
        const SizedBox(height: 16),
        _HubCard(
          title: 'Configuración',
          subtitle: 'Ajustes de tema y información de la aplicación',
          icon: Icons.settings,
          route: '/settings',
          isWeb: isWeb,
        ),
      ],
    );
  }
}

class _HubCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final bool isWeb;

  const _HubCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.isWeb,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: isWeb ? 120 : 100,
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: isWeb ? 32 : 28, color: Colors.blue.shade700),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isWeb ? 20 : 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: isWeb ? 14 : 13,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 20,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}