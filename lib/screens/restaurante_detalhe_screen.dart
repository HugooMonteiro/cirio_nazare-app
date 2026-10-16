import 'package:flutter/material.dart';
import '../models/restaurante.dart';

class RestauranteDetalheScreen extends StatelessWidget {
  final Restaurante restaurante;

  const RestauranteDetalheScreen({super.key, required this.restaurante});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurante.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restaurante.nome, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(restaurante.endereco, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Text(restaurante.descricao, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Especialidades:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: restaurante.especialidades
                  .map((e) => Chip(label: Text(e)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
