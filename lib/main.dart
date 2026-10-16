import 'package:flutter/material.dart';
import 'package:light_sensor/light_sensor.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CirioApp());
}

class CirioApp extends StatefulWidget {
  const CirioApp({super.key});

  @override
  State<CirioApp> createState() => _CirioAppState();
}

class _CirioAppState extends State<CirioApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _iniciarSensorDeLuz();
  }

  Future<void> _iniciarSensorDeLuz() async {
    final temSensor = await LightSensor.hasSensor();
    if (!temSensor) return;

    LightSensor.luxStream().listen((lux) {
      // abaixo de 15 lux = ambiente escuro -> tema escuro
      final novoTema = lux < 15 ? ThemeMode.dark : ThemeMode.light;
      if (novoTema != _themeMode) {
        setState(() => _themeMode = novoTema);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Círio de Nazaré',
      themeMode: _themeMode,
      theme: ThemeData(primarySwatch: Colors.orange, brightness: Brightness.light),
      darkTheme: ThemeData(primarySwatch: Colors.orange, brightness: Brightness.dark),
      home: const HomeScreen(),
    );
  }
}
