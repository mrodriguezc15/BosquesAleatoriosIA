// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'pages/menu_page.dart' as menu; // Cambié el nombre a 'menu'
import 'pages/result_page.dart';
import 'pages/load_data_page.dart';
import 'pages/register_page.dart' as register; // Cambié el nombre a 'register'
import 'models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Operar IA',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => MyHomePage(),
          '/menu': (context) => menu.MenuPage(), // Usando 'menu' como prefijo
          '/result': (context) => ResultPage(),
          '/load_data': (context) => LoadDataPage(),
          '/register': (context) => register.RegisterPage(), // Usando 'register' como prefijo
        },
        initialRoute: '/',
        onGenerateRoute: (settings) {
          print('Ruta solicitada: ${settings.name}');
          return MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: Text('Página no encontrada'))));
        }
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String result = "";
  List<User> users = [];

  void setResult(String newResult) {
    result = newResult;
    notifyListeners();
  }

  void addUser(User user) {
    users.add(user);
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Profile'),
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (value) {
                print('selected: $value');
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: HomeContent(),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bienvenido',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'A través de algoritmos de red neuronal y bosques aleatorios, la aplicación realiza una validación y análisis profundo de los datos en el archivo. Estos algoritmos permiten a la aplicación identificar patrones, tendencias y relaciones complejas.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              appState.setResult("Resultado Generación de Algoritmo");
              Navigator.pushReplacementNamed(context, '/result');
            },
            child: Text('Analizar Resultados'),
          ),
        ],
      ),
    );
  }
}
