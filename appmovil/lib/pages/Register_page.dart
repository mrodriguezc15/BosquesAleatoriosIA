import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/my_app_state.dart';
import '../models/user_model.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();

  void _handleRegistro(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String nombre = _nombreController.text;
    String apellido = _apellidoController.text;

    // Crear un nuevo usuario
    User newUser = User(username: username, password: password, nombre: nombre, apellido: apellido);

    // Agregar el nuevo usuario al estado global
    context.read<MyAppState>().addUser(newUser);

    // Mostrar mensaje de éxito o navegar a otra página
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ingrese la información para registrarse:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _apellidoController,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _handleRegistro(context),
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
