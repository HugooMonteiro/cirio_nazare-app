import 'ponto_coordenada.dart';

class TrajetoCirio {
  final int id;
  final String nome;
  final String data;
  final double distanciaKm;
  final PontoCoordenada inicio;
  final PontoCoordenada fim;
  final List<PontoCoordenada> pontos;

  TrajetoCirio({
    required this.id,
    required this.nome,
    required this.data,
    required this.distanciaKm,
    required this.inicio,
    required this.fim,
    required this.pontos,
  });

  factory TrajetoCirio.fromJson(Map<String, dynamic> json) {
    return TrajetoCirio(
      id: json['id'],
      nome: json['nome'],
      data: json['data'],
      distanciaKm: (json['distancia_km'] as num).toDouble(),
      inicio: PontoCoordenada.fromJson(json['inicio']),
      fim: PontoCoordenada.fromJson(json['fim']),
      pontos: (json['pontos'] as List).map((p) => PontoCoordenada.fromJson(p)).toList(),
    );
  }
}
