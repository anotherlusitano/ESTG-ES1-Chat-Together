import 'package:flutter/material.dart';

class ItemAmigo extends StatefulWidget {
  const ItemAmigo({Key? key}) : super(key: key);

  @override
  ItemAmigoEstado createState() => ItemAmigoEstado(
      quantidade_amigos: 0,
      amigo_selecionado: 0,
      mensagens: [],
      scroll_chat: ScrollController());
}

class ItemAmigoEstado extends State<ItemAmigo> {
  int quantidade_amigos, amigo_selecionado;
  List<String> mensagens;
  ScrollController scroll_chat;

  ItemAmigoEstado(
      {required this.quantidade_amigos,
      required this.amigo_selecionado,
      required this.mensagens,
      required this.scroll_chat});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: quantidade_amigos,
        itemBuilder: (context, i) {
          return Column(children: [
            GestureDetector(
                child: Container(
                    color: amigo_selecionado == i + 1
                        ? Colors.blueGrey[200]
                        : Colors.grey[300],
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(title: Text("")),
                          Divider(thickness: 1, color: Colors.black)
                        ])),
                onTap: () {
                  setState(() {
                    amigo_selecionado = i + 1;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      scroll_chat.animateTo(
                          scroll_chat.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut);
                    });
                  });
                })
          ]);
        });
  }
}
