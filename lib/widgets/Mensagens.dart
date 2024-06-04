import 'package:flutter/material.dart';

class Mensagem extends StatelessWidget {
  final String emissor;
  final String mensagem;
  final String data;

  const Mensagem(
      {required this.emissor, required this.mensagem, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: emissor == "Você"
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color:
                      emissor == "Você" ? Colors.blue[200] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(mensagem)),
          SizedBox(height: 5.0),
          Padding(
              padding: emissor == "Você"
                  ? const EdgeInsets.only(right: 10.0)
                  : const EdgeInsets.only(left: 10.0),
              child: Text(
                  emissor == "Você" ? "Você • $data" : "$emissor • $data",
                  style: TextStyle(fontSize: 12))),
          SizedBox(height: 25.0)
        ]);
  }
}
