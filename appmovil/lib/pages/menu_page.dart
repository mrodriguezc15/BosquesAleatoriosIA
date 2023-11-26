import 'package:appmovil/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido', // Mensaje de bienvenida
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'A través de algoritmos de red neuronal y bosques aleatorios, la aplicación realiza una validación y análisis profundo de los datos en el archivo. Estos algoritmos permiten a la aplicación identificar patrones, tendencias y relaciones complejas.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para analizar resultados
                appState.setResult("Resultado del análisis de resultados");
                // Navegar a la página de resultados (/result)
                Navigator.pushNamed(context, '/result');
              },
              child: Text('Analizar Resultados'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de carga de datos
                Navigator.pushNamed(context, '/load_data');
              },
              child: Text('Cargar Nuevos Datos'),
            ),
          ],
        ),
      ),
    );
  }
}
