import 'package:flutter/material.dart';

class ItemAmigo extends StatefulWidget {
  final String username;
  final String utilizadorSelecionado;
  final bool selecionado;

  const ItemAmigo({
    super.key,
    required this.selecionado,
    required this.username,
    required this.utilizadorSelecionado,
  });

  @override
  State<ItemAmigo> createState() => _ItemAmigoState();
}

class _ItemAmigoState extends State<ItemAmigo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.selecionado && widget.utilizadorSelecionado == widget.username
          ? Colors.blueGrey[200]
          : Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(title: Text(widget.username)),
          const Divider(thickness: 1, color: Colors.black),
        ],
      ),
    );
  }
}
