import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_together/widgets/botao_principal.dart';
import 'package:chat_together/paginas/pagina_sign_up.dart';
import 'package:chat_together/paginas/pagina_home.dart';

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  // vai verificar se existe conta
  // se não houver vai mandar erro
  // se algo estiver mal, vai dar erro
  // enquanto isso vai mostrar um círculo de loading
  void entrar_na_conta() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );

      //pop loading circule
      if (context.mounted) Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaginaHome()),
      );
    } on FirebaseAuthException catch (erro) {
      // sair do circulo de loading
      Navigator.pop(context);

      mostrar_mensagem_erro(erro.message!);
    }
  }

  void mostrar_mensagem_erro(String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(mensagem),
      ),
    );
  }

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
                width: 280,
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
                width: 280,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Insira a palavra-passe...',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey[400],
                      ),
                      onPressed: () {
                        setState(
                          () {
                            _showPassword = !_showPassword;
                          },
                        );
                      },
                    ),
                  ),
                  obscureText: !_showPassword,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 180,
                child: BotaoPrincipal(
                  onTap: entrar_na_conta,
                  text: 'Entrar',
                ),
              ),
              SizedBox(height: 40),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaginaSignUp(),
                            ),
                          );
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
