import 'package:flutter/material.dart';
import 'noticias_screen.dart';
import 'eventos_screen.dart';
import 'restaurantes_screen.dart';
import 'mapa_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Círio de Nazaré')),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _MenuCard(
            icon: Icons.newspaper,
            label: 'Notícias',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NoticiasScreen()),
            ),
          ),
          _MenuCard(
            icon: Icons.event,
            label: 'Agenda Cultural',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EventosScreen()),
            ),
          ),
          _MenuCard(
            icon: Icons.restaurant,
            label: 'Restaurantes',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RestaurantesScreen()),
            ),
          ),
          _MenuCard(
            icon: Icons.map,
            label: 'Mapa do Círio',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MapaScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuCard({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.orange),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
