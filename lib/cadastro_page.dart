import 'package:flutter/material.dart';


class CadastroPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<Map<String, String>> usuarios; // Lista de usuários passada como parâmetro

  CadastroPage({required this.usuarios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Adicionar usuário à lista de usuários
                usuarios.add({
                  'email': emailController.text,
                  'password': passwordController.text,
                });
                Navigator.pop(context);
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}