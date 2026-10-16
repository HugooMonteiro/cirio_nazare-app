class Restaurante {
  final int id;
  final String nome;
  final String descricao;
  final String endereco;
  final List<String> especialidades;
  final double latitude;
  final double longitude;

  Restaurante({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.endereco,
    required this.especialidades,
    required this.latitude,
    required this.longitude,
  });

  factory Restaurante.fromJson(Map<String, dynamic> json) {
    return Restaurante(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      endereco: json['endereco'],
      especialidades: List<String>.from(json['especialidades']),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
