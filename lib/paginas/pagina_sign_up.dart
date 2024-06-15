import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaming_together/paginas/pagina_home.dart';
import 'package:gaming_together/widgets/botao_principal.dart';

class PaginaSignUp extends StatefulWidget {
  @override
  _PaginaSignUpState createState() => _PaginaSignUpState();
}

class _PaginaSignUpState extends State<PaginaSignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  Future<bool> usernameExist() async {
    final db = FirebaseFirestore.instance.collection('Utilizadores');

    QuerySnapshot snapshot =
        await db.where('username', isEqualTo: _usernameController.text).get();

    return snapshot.size > 0 ? true : false;
  }

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (_usernameController.text.isEmpty) {
      Navigator.pop(context);

      displayErrorMessage('Insira um Username!');
      return;
    }

    if (_passwordController.text.isEmpty) {
      Navigator.pop(context);

      displayErrorMessage('Insira uma Password!');
      return;
    }

    if (await usernameExist()) {
      Navigator.pop(context);

      displayErrorMessage('Esse Username já existe, tente um diferente!');
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      FirebaseFirestore.instance
          .collection('Utilizadores')
          .doc(userCredential.user!.uid)
          .set(
        {
          'username': _usernameController.text,
          'amigos': [],
          'convites': [],
        },
      );

      if (context.mounted) Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaginaHome(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      displayErrorMessage(e.code);
    }
  }

  void displayErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
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
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        margin: const EdgeInsets.only(
                          right: 16.0,
                        ),
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
                  'assets/chat-together-icon.png',
                  height: 250,
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
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                  width: 150,
                  child: BotaoPrincipal(
                    onTap: signUp,
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
