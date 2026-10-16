import 'package:flutter/material.dart';
import '../models/noticia.dart';
import '../services/api_service.dart';
import 'noticia_detalhe_screen.dart';

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({super.key});

  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Noticia>> _futureNoticias;

  @override
  void initState() {
    super.initState();
    _futureNoticias = _apiService.listarNoticias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notícias')),
      body: FutureBuilder<List<Noticia>>(
        future: _futureNoticias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final noticias = snapshot.data!;
          return ListView.builder(
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final n = noticias[index];
              return ListTile(
                leading: Image.network(n.imagem, width: 60, fit: BoxFit.cover),
                title: Text(n.titulo),
                subtitle: Text(n.resumo, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NoticiaDetalheScreen(noticia: n)),
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
