import 'package:flutter/material.dart';
import '../models/noticia.dart';

class NoticiaDetalheScreen extends StatelessWidget {
  final Noticia noticia;

  const NoticiaDetalheScreen({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(noticia.titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(noticia.imagem, width: double.infinity, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(noticia.data, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(noticia.titulo, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(noticia.conteudo, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
