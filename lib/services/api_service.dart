import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/noticia.dart';
import '../models/evento.dart';
import '../models/restaurante.dart';
import '../models/trajeto_cirio.dart';
import '../models/ponto_importante.dart';
import '../models/rota_ate_inicio.dart';

class ApiService {
  static const String baseUrl = 'https://cirio-belem-api.onrender.com';

  Future<List<Noticia>> listarNoticias() async {
    final res = await http.get(Uri.parse('$baseUrl/noticias'));
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((json) => Noticia.fromJson(json)).toList();
    }
    throw Exception('Erro ao carregar notícias');
  }

  Future<List<Evento>> listarEventos() async {
    final res = await http.get(Uri.parse('$baseUrl/eventos'));
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((json) => Evento.fromJson(json)).toList();
    }
    throw Exception('Erro ao carregar eventos');
  }

  Future<List<Restaurante>> listarRestaurantes() async {
    final res = await http.get(Uri.parse('$baseUrl/restaurantes'));
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((json) => Restaurante.fromJson(json)).toList();
    }
    throw Exception('Erro ao carregar restaurantes');
  }

  Future<List<PontoImportante>> listarPontosMapa() async {
    final res = await http.get(Uri.parse('$baseUrl/mapa/pontos'));
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((json) => PontoImportante.fromJson(json)).toList();
    }
    throw Exception('Erro ao carregar pontos do mapa');
  }

  Future<TrajetoCirio> obterTrajetoCirio() async {
    final res = await http.get(Uri.parse('$baseUrl/mapa/cirio'));
    if (res.statusCode == 200) return TrajetoCirio.fromJson(jsonDecode(res.body));
    throw Exception('Erro ao carregar trajeto');
  }

  Future<RotaAteInicio> obterRotaAteInicio(double lat, double lng) async {
    final uri = Uri.parse('$baseUrl/rota/ate-inicio?latitude=$lat&longitude=$lng');
    final res = await http.get(uri);
    if (res.statusCode == 200) return RotaAteInicio.fromJson(jsonDecode(res.body));
    throw Exception('Erro ao calcular rota');
  }
}
