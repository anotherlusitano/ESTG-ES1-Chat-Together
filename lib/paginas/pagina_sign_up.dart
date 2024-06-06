import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gaming_together/widgets/botao_principal.dart';

class Login_SingUp extends StatefulWidget {
  @override
  _Login_SingUpState createState() => _Login_SingUpState();
}

class _Login_SingUpState extends State<Login_SingUp> {
  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 16.0),
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 30,
        ),
      ),
    )
                  ],
                ),
                SizedBox(height: 10),
                Image.asset(
                  'assets/avatar.png',
                  height: 150,
                ),
                SizedBox(height: 10),
                Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insira o username...',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 1),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insira o email...',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 250,
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
                  width: 150,
                  child: BotaoPrincipal(
                    onTap: () {
                    },
                    text: 'Criar',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
