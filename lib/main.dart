import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gaming_together/firebase_options.dart';
import 'package:gaming_together/paginas/pagina_login.dart';

void main() async {
  // isto serve para garantir que o firebase é inicializado
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Together',
      home: PaginaLogin(),
    );
  }
}
