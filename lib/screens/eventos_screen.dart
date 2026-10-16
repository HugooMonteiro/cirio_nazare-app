import 'package:flutter/material.dart';
import '../models/evento.dart';
import '../services/api_service.dart';
import 'evento_detalhe_screen.dart';

class EventosScreen extends StatefulWidget {
  const EventosScreen({super.key});

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Evento>> _futureEventos;

  @override
  void initState() {
    super.initState();
    _futureEventos = _apiService.listarEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda Cultural')),
      body: FutureBuilder<List<Evento>>(
        future: _futureEventos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final eventos = snapshot.data!;
          return ListView.builder(
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              final e = eventos[index];
              return ListTile(
                leading: const Icon(Icons.event, size: 36),
                title: Text(e.nome),
                subtitle: Text('${e.data} às ${e.horario} - ${e.local}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EventoDetalheScreen(evento: e)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
