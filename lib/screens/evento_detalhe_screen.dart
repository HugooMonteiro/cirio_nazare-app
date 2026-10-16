import 'package:flutter/material.dart';
import '../models/evento.dart';

class EventoDetalheScreen extends StatelessWidget {
  final Evento evento;

  const EventoDetalheScreen({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(evento.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(evento.nome, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${evento.data} às ${evento.horario}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Text('Local: ${evento.local}'),
            const SizedBox(height: 16),
            Text(evento.descricao, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
