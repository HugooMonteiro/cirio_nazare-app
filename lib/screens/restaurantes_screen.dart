import 'package:flutter/material.dart';
import '../models/restaurante.dart';
import '../services/api_service.dart';
import 'restaurante_detalhe_screen.dart';

class RestaurantesScreen extends StatefulWidget {
  const RestaurantesScreen({super.key});

  @override
  State<RestaurantesScreen> createState() => _RestaurantesScreenState();
}

class _RestaurantesScreenState extends State<RestaurantesScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Restaurante>> _futureRestaurantes;

  @override
  void initState() {
    super.initState();
    _futureRestaurantes = _apiService.listarRestaurantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gastronomia Paraense')),
      body: FutureBuilder<List<Restaurante>>(
        future: _futureRestaurantes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final restaurantes = snapshot.data!;
          return ListView.builder(
            itemCount: restaurantes.length,
            itemBuilder: (context, index) {
              final r = restaurantes[index];
              return ListTile(
                leading: const Icon(Icons.restaurant, size: 36),
                title: Text(r.nome),
                subtitle: Text(r.endereco),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RestauranteDetalheScreen(restaurante: r)),
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
