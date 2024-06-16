import 'package:flutter/material.dart';

class Mensagem extends StatelessWidget {
  final String emissor;
  final String utilizadorSelecionado;
  final String mensagem;
  final String data;

  const Mensagem({
    super.key,
    required this.emissor,
    required this.utilizadorSelecionado,
    required this.mensagem,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: emissor == utilizadorSelecionado ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450.0),
                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: emissor == utilizadorSelecionado ? Colors.blue[200] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(mensagem),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: emissor == utilizadorSelecionado ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                emissor == utilizadorSelecionado ? "Você • $data" : "$emissor • $data",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25.0),
      ],
    );
  }
}
