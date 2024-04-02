import 'package:flutter/material.dart';
import 'package:telalogin/cadastro_page.dart';
import 'package:telalogin/home_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //banco de dados de usuários
  static List<Map<String, String>> usuarios = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Tarefas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                if (isUserRegistered(emailController.text, passwordController.text)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erro'),
                        content: Text('Usuário não cadastrado.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroPage(usuarios: usuarios)),
                );
              },
              child: Text('Cadastro'),
            ),
          ],
        ),
      ),
    );
  }

 
  bool isUserRegistered(String email, String password) {
    for (var usuario in usuarios) {
      if (usuario['email'] == email && usuario['password'] == password) {
        return true;
      }
    }
    return false;
  }
}