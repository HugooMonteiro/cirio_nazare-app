import 'ponto_coordenada.dart';

class RotaAteInicio {
  final double distanciaMetros;
  final double duracaoSegundos;
  final List<PontoCoordenada> pontos;

  RotaAteInicio({
    required this.distanciaMetros,
    required this.duracaoSegundos,
    required this.pontos,
  });

  factory RotaAteInicio.fromJson(Map<String, dynamic> json) {
    return RotaAteInicio(
      distanciaMetros: (json['distancia_metros'] as num).toDouble(),
      duracaoSegundos: (json['duracao_segundos'] as num).toDouble(),
      pontos: (json['pontos'] as List)
          .map((p) => PontoCoordenada.fromJson(p))
          .toList(),
    );
  }
}
