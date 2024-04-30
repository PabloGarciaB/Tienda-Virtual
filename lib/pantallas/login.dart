import 'package:flutter/material.dart';
import 'package:tienda_virtual/api/obtener_info_api.dart';

import 'package:tienda_virtual/api/validar_usuario_api.dart';
import 'package:tienda_virtual/pantallas/inicio.dart';

class Login extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 130, 84, 211),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Nombre de usuario'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña:'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: Text('Entrar'))
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final api = ApiService();
    final sesionExitosa = await api.loginUser(username, password);

    if (sesionExitosa) {
      final userdata = await obtenerData(username);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Inicio(userData: userdata),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Usuario o contraseña incorrecta'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      );
    }
  }
}
