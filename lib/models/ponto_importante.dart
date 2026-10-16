class PontoImportante {
  final int id;
  final String nome;
  final String tipo;
  final String descricao;
  final double latitude;
  final double longitude;

  PontoImportante({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.descricao,
    required this.latitude,
    required this.longitude,
  });

  factory PontoImportante.fromJson(Map<String, dynamic> json) {
    return PontoImportante(
      id: json['id'],
      nome: json['nome'],
      tipo: json['tipo'],
      descricao: json['descricao'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
