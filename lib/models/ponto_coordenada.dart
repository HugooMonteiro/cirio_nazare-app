class PontoCoordenada {
  final String? nome;
  final int? ordem;
  final double latitude;
  final double longitude;

  PontoCoordenada({this.nome, this.ordem, required this.latitude, required this.longitude});

  factory PontoCoordenada.fromJson(Map<String, dynamic> json) {
    return PontoCoordenada(
      nome: json['nome'],
      ordem: json['ordem'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
