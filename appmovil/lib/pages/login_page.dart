import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  // Mantenemos el estado del resultado
  String result = "";

  // Función para cambiar el resultado
  void setResult(String newResult) {
    result = newResult;
    notifyListeners();
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Lógica de autenticación aquí
    if (username == 'admin' && password == '123') {
      // Autenticación exitosa, navegar a la página del menú
      Navigator.pushNamed(context, '/menu');
    } else {
      // Autenticación fallida, mostrar un mensaje de error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error de autenticación'),
            content: Text('Usuario o contraseña incorrectos. Por favor, inténtalo de nuevo.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar el cuadro de diálogo
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

void _handleRegistration(BuildContext context) {
  // Mostrar pantalla de registro
  Navigator.pushNamed(context, '/register');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingrese su usuario y contraseña:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handleLogin(context),
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => _handleRegistration(context),
              child: Text('¿No tienes una cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}