import "package:flutter/material.dart";
import "package:gaming_together/widgets/Mensagens.dart";

class PaginaMensagens extends StatefulWidget {
  const PaginaMensagens({Key? key}) : super(key: key);

  @override
  PaginaMensagensEstado createState() => PaginaMensagensEstado();
}

class PaginaMensagensEstado extends State<PaginaMensagens> {
  int quantidade_amigos = 13, amigo_selecionado = 0;
  List<String> mensagens = [];

  TextEditingController mensagem_enviada = TextEditingController();
  ScrollController scroll_chat = ScrollController();
  FocusNode selecionar_caixatexto = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Chat Together",
        home: Scaffold(
            body: Row(children: [
          Expanded(
              flex: 1,
              child: Column(children: [
                if (quantidade_amigos == 0)
                  Expanded(
                      child: Column(children: [
                    Spacer(),
                    Text("Sem amigos", style: TextStyle(fontSize: 20)),
                    Spacer()
                  ]))
                else
                  Expanded(
                      child: ListView.builder(
                          itemCount: quantidade_amigos,
                          itemBuilder: (context, i) {
                            return Column(children: [
                              GestureDetector(
                                  child: Container(
                                      color: amigo_selecionado == i + 1
                                          ? Colors.blueGrey[200]
                                          : Colors.grey[300],
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ListTile(title: Text("")),
                                            Divider(
                                                thickness: 1,
                                                color: Colors.black)
                                          ])),
                                  onTap: () {
                                    setState(() {
                                      amigo_selecionado = i + 1;

                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        scroll_chat.animateTo(
                                            scroll_chat
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                      });
                                    });
                                  })
                            ]);
                          })),
                Divider(thickness: 1, color: Colors.black),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(children: [
                      Expanded(
                          child: IconButton(
                              iconSize: 50,
                              icon: Icon(Icons.message, color: Colors.blue),
                              onPressed: () {})),
                      Expanded(
                          child: IconButton(
                              iconSize: 50,
                              icon: Icon(Icons.email, color: Colors.black),
                              onPressed: () {}))
                    ]))
              ])),
          VerticalDivider(width: 1, color: Colors.black),
          Expanded(
              flex: 3,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                if (amigo_selecionado != 0)
                  if (mensagens[amigo_selecionado - 1].length == 0)
                    Expanded(
                        child: Column(children: [
                      Spacer(),
                      Text("Sem mensagens", style: TextStyle(fontSize: 20))
                    ])),
                if (amigo_selecionado != 0)
                  if (mensagens[amigo_selecionado - 1].length != 0)
                    Expanded(
                        flex: 20,
                        child: ListView.builder(
                            controller: scroll_chat,
                            itemCount: mensagens[amigo_selecionado - 1].length,
                            itemBuilder: (context, i) {
                              return Mensagem(
                                  emissor: "", mensagem: "", data: "");
                            })),
                if (amigo_selecionado == 0)
                  Expanded(
                      flex: 3,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Image.asset("assets/chat-together-icon.png",
                                width: 200, height: 200),
                            SizedBox(height: 10),
                            Text("Bem-vindo!", style: TextStyle(fontSize: 24)),
                            Text("Vem chattar connosco!",
                                style: TextStyle(fontSize: 24)),
                          ])),
                Spacer(),
                if (amigo_selecionado != 0)
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                                    width: 400,
                                    child: TextField(
                                        focusNode: selecionar_caixatexto,
                                        controller: mensagem_enviada,
                                        onSubmitted: (value) {
                                          setState(() {
                                            if (mensagem_enviada
                                                .text.isNotEmpty) {
                                              mensagem_enviada.clear();

                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                scroll_chat.animateTo(
                                                    scroll_chat.position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeOut);
                                              });

                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      selecionar_caixatexto);
                                            }
                                          });
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            hintText: "Enviar mensagem",
                                            suffixIcon: IconButton(
                                                icon: Icon(Icons.send),
                                                onPressed: () {
                                                  setState(() {
                                                    if (mensagem_enviada
                                                        .text.isNotEmpty) {
                                                      mensagem_enviada.clear();

                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) {
                                                        scroll_chat.animateTo(
                                                            scroll_chat.position
                                                                .maxScrollExtent,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    300),
                                                            curve:
                                                                Curves.easeOut);
                                                      });

                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              selecionar_caixatexto);
                                                    }
                                                  });
                                                }))))),
                            SizedBox(width: 20),
                            IconButton(
                                iconSize: 40,
                                icon: Icon(Icons.logout),
                                onPressed: () {})
                          ])),
                if (amigo_selecionado == 0)
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.logout),
                        onPressed: () {})
                  ])
              ]))
        ])));
  }
}
