import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:ESTG-ES1-Chat-Together/lib/widgets/botao_principal.dart'

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/chat-together-icon.png',
                height: 250,
              ),
              SizedBox(height: 20),
              Text(
                'Username',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 280, // Ajustando a largura para médio
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Insira o username...',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 280, // Ajustando a largura para médio
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Insira a palavra-passe...',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey[400], // Definindo a cor do ícone
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_showPassword,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 180, // Ajustando a largura para médio
                child: BotaoPrincipal(
                  onTap: () {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    print('Username: $username, Password: $password');
                  },
                  text: 'Entrar',
                ),
              ),
              SizedBox(height: 40), // Aumentando o espaçamento para o link
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'Não tem uma conta? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Crie aqui!',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Navegar para criar conta');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
