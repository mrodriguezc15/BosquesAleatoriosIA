import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String resultado = 'Contenido del análisis aquí';

  String obtenerDireccionServidor() {
    // Comprueba si la aplicación se está ejecutando en un emulador de Android
    if (Uri.base.scheme == 'file') {
      return 'http://10.0.2.2:5000';
    } else {
      // La aplicación se está ejecutando en la web
      return 'http://localhost:5000';
    }
  }

  Future<void> _realizarSolicitud(String endpoint) async {
    try {
      final url = Uri.parse('${obtenerDireccionServidor()}/api/$endpoint');
      final respuesta = await http.post(url);

      if (respuesta.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(respuesta.body);
        final nuevoResultado = jsonResponse['resultado'];
        setState(() {
          resultado = _formatearResultado(nuevoResultado, endpoint);
        });
      } else {
        print('Error en la solicitud: ${respuesta.statusCode}');
        setState(() {
          resultado = 'Error en la solicitud: ${respuesta.statusCode}';
        });
      }
    } catch (error) {
      print('Error en la solicitud: $error');
      setState(() {
        resultado = 'Error en la solicitud: $error';
      });
    }
  }

  String _formatearResultado(String resultado, String endpoint) {
    final precision = RegExp(r"(\d+\.\d+)%").firstMatch(resultado)?.group(1);
    if (precision != null) {
      final algoritmo =
          endpoint == 'bosquesAleatorios' ? 'Bosques Aleatorios' : 'Red Neuronal';
      return 'El conjunto de prueba para $algoritmo fue de: $precision%';
    }
    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados del Análisis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 150,
              color: const Color.fromARGB(255, 107, 108, 108),
              child: Center(
                child: Text(
                  resultado,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _realizarSolicitud('bosquesAleatorios');
                  },
                  child: Text('Bosques Aleatorios'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _realizarSolicitud('redNeuronal');
                  },
                  child: Text('Red Neuronal'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Atrás'),
            ),
          ],
        ),
      ),
    );
  }
}
