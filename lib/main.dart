import 'package:flutter/material.dart';
import 'package:gaming_together/paginas/pagina_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gaming Together',
      home: PaginaLogin(),
    );
  }
}
