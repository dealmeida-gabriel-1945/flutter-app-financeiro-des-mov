
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login_screen/splash.dart';
import 'package:login_screen/visao/usuario/cad_usuario.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage>{
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _savePassword = true;
  final Random _randomizer = Random();
  final _usernamesExamples = ['ImAwesome123', 'FriendlySquirrel37'];

  String getExampleUsername(){
    return _usernamesExamples[_randomizer.nextInt(_usernamesExamples.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _userController,
              decoration: InputDecoration(
                icon: const Icon(Icons.supervised_user_circle),
                labelText: 'CPF',
                hintText: getExampleUsername() + ', ...',
              ),
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: 'Senha',
                hintText: '*******',
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 30), // double.infinity is the width and 30 is the height
              ),
              onPressed: () {
                debugPrint('Username: ' + _userController.text + '\n Password: ' + _passwordController.text);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Splash()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: TextButton(
                onPressed: () {
                  debugPrint('Esqueci minha senha!');
                },
                child: const Text('Esqueci minha senha!')
            )
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadUsuario()),
                  );
                },
                child: const Text('Criar conta!')
            )
          ),
        ],
      ),
    );
  }
}
