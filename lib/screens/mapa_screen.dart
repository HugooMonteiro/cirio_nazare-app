import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';
import '../models/trajeto_cirio.dart';
import '../models/ponto_importante.dart';
import '../models/rota_ate_inicio.dart';
import '../services/api_service.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final ApiService _apiService = ApiService();
  final MapController _mapController = MapController();
  ShakeDetector? _shakeDetector;

  TrajetoCirio? _trajeto;
  List<PontoImportante> _pontos = [];
  LatLng? _posicaoUsuario;
  RotaAteInicio? _rota;
  String? _erro;
  bool _carregando = true;
  bool _buscandoRota = false;

  @override
  void initState() {
    super.initState();
    _carregarDados();
    _shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: (event) {
        if (_posicaoUsuario != null) {
          _mapController.move(_posicaoUsuario!, _mapController.camera.zoom);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Recentralizando na sua posição'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _shakeDetector?.stopListening();
    super.dispose();
  }

  Future<void> _carregarDados() async {
    try {
      final trajeto = await _apiService.obterTrajetoCirio();
      final pontos = await _apiService.listarPontosMapa();
      final posicao = await _obterLocalizacaoUsuario();

      setState(() {
        _trajeto = trajeto;
        _pontos = pontos;
        _posicaoUsuario = posicao;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _carregando = false;
      });
    }
  }

  Future<LatLng?> _obterLocalizacaoUsuario() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();
    if (!servicoAtivo) return null;

    LocationPermission permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) return null;
    }
    if (permissao == LocationPermission.deniedForever) return null;

    try {
      final posicao = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 10));
      return LatLng(posicao.latitude, posicao.longitude);
    } catch (e) {
      return null;
    }
  }

  Future<void> _calcularRotaAteInicio() async {
    if (_posicaoUsuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Localização do usuário indisponível')),
      );
      return;
    }

    setState(() => _buscandoRota = true);
    try {
      final rota = await _apiService.obterRotaAteInicio(
        _posicaoUsuario!.latitude,
        _posicaoUsuario!.longitude,
      );
      setState(() => _rota = rota);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao calcular rota: $e')),
      );
    } finally {
      setState(() => _buscandoRota = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return Scaffold(
        appBar: AppBar(title: const Text('Mapa do Círio')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_erro != null || _trajeto == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Mapa do Círio')),
        body: Center(child: Text('Erro: $_erro')),
      );
    }

    final trajeto = _trajeto!;
    final centro = _posicaoUsuario ??
        LatLng(trajeto.inicio.latitude, trajeto.inicio.longitude);

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa do Círio')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _buscandoRota ? null : _calcularRotaAteInicio,
        icon: _buscandoRota
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : const Icon(Icons.directions_walk),
        label: Text(_buscandoRota ? 'Calculando...' : 'Rota até o início'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: centro,
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app_cirio',
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: trajeto.pontos
                    .map((p) => LatLng(p.latitude, p.longitude))
                    .toList(),
                strokeWidth: 4,
                color: Colors.deepOrange,
              ),
              if (_rota != null)
                Polyline(
                  points: _rota!.pontos
                      .map((p) => LatLng(p.latitude, p.longitude))
                      .toList(),
                  strokeWidth: 4,
                  color: Colors.blue,
                  pattern: const StrokePattern.dotted(),
                ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(trajeto.inicio.latitude, trajeto.inicio.longitude),
                width: 40,
                height: 40,
                child: const Icon(Icons.flag, color: Colors.green, size: 36),
              ),
              Marker(
                point: LatLng(trajeto.fim.latitude, trajeto.fim.longitude),
                width: 40,
                height: 40,
                child: const Icon(Icons.flag_circle, color: Colors.red, size: 36),
              ),
              ..._pontos.map(
                (p) => Marker(
                  point: LatLng(p.latitude, p.longitude),
                  width: 36,
                  height: 36,
                  child: Tooltip(
                    message: p.nome,
                    child: const Icon(Icons.place, color: Colors.blue, size: 30),
                  ),
                ),
              ),
              if (_posicaoUsuario != null)
                Marker(
                  point: _posicaoUsuario!,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.my_location, color: Colors.deepPurple, size: 34),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
