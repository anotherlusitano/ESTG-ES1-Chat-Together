import "package:flutter/material.dart";
//import ""; //Página Login
//import ""; //Página Home

void main() {
  runApp(Pagina_Mensagens());
}

class Chat {
  String mensagem, emissor, data;

  Chat(this.mensagem, this.emissor, this.data);
}

class Pagina_Mensagens extends StatefulWidget {
  const Pagina_Mensagens({Key? key}) : super(key: key);

  @override
  Pagina_MensagensEstado createState() => Pagina_MensagensEstado();
}

class Pagina_MensagensEstado extends State<Pagina_Mensagens> {
  int quantidade_amigos = 13, utilizador_selecionado = 0;
  //O número de quantidade de amigos, tem que ser igual ao tamanho do array, e igual ao tamanho de linhas de mensagens
  //Esta lista de amigos são exemplos, que vai ser aqui depois adicionar o código para ser lista de amizades da base de dados
  List<String> utilizadores = [
    "RicFazeres",
    "okan",
    "4Hands",
    "gordao726",
    "coffee2dev",
    "portal_sun_enjoyer",
    "guizinsx",
    "ruan363",
    "requiem",
    "nevertolatos",
    "zfuegodasilva",
    "lucielucie",
    "clebin"
  ];
  //Esta lista de mensagens são exemplos, que vai ser aqui depois adicionar o código para ser lista de mensagens de cada conversa da base de dados
  List<List<Chat>> mensagens = [
    [
      Chat("Ric, me dá um salve, por favor", "Você", "15-03-2024 14:27"),
      Chat("Este utilizador acabou de bloquear você!", "RicFazeres",
          "15-03-2024 14:27")
    ],
    [],
    [
      Chat("Ei", "4Hands", "05-12-2023 03:14"),
      Chat("Podes-me passar as respostas do TPC? Por favor. :')", "4Hands",
          "05-12-2023 03:15"),
      Chat("Porque tu foste perguntar isso em plenas 3 da manhã?", "Você",
          "05-12-2023 09:24"),
      Chat("Não tens mais que fazer?", "Você", "05-12-2023 09:25")
    ],
    [
      Chat("Olá baleia mecânica", "Você", "12-05-2024 20:13"),
      Chat(
          "Comeu quantos BigMac hoje, seu balofo?", "Você", "12-05-2024 20:13"),
      Chat("Que balofo o quê?", "gordao726", "12-05-2024 22:15"),
      Chat("Tu és idiota?", "gordao726", "12-05-2024 22:16"),
      Chat("Já falei que sou musculado", "gordao726", "12-05-2024 22:16"),
      Chat("100Kg massa magra", "gordao726", "12-05-2024 22:16")
    ],
    [],
    [
      Chat("Oi Portal", "Você", "06-03-2021 18:24"),
      Chat("Me responde", "Você", "06-03-2021 18:24"),
      Chat("Não me ignores", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Portal", "Você", "06-03-2021 18:24"),
      Chat("Tu estás muito chato", "portal_sun_enjoyer", "06-03-2021 18:32"),
      Chat("Para de me chatear", "portal_sun_enjoyer", "06-03-2021 18:32"),
      Chat("Por favor", "portal_sun_enjoyer", "06-03-2021 18:33"),
      Chat("Mais respeito, por favor", "portal_sun_enjoyer", "06-03-2021 18:33")
    ],
    [],
    [],
    [],
    [],
    [],
    [],
    []
  ];
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
                if (quantidade_amigos == 0) //Caso não haja amigos
                  Expanded(
                      child: Column(children: [
                    Spacer(),
                    Text("Sem amigos", style: TextStyle(fontSize: 20)),
                    Spacer()
                  ]))
                else
                  Expanded(
                      //Caso haja amigos
                      child: ListView.builder(
                          //Mostra todos os amigos
                          itemCount: quantidade_amigos,
                          itemBuilder: (context, i) {
                            return Column(children: [
                              GestureDetector(
                                  child: Container(
                                      color: utilizador_selecionado == i + 1
                                          ? Colors.blueGrey[200]
                                          : Colors.grey[300],
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ListTile(
                                                title: Text(utilizadores[i])
                                                //O subtitle era para aparecer a última mensagem do chat
                                                //subtitle: Text("${mensagens[i].last.emissor}: ${mensagens[i].last.mensagem}")
                                                ),
                                            Divider(
                                                thickness: 1,
                                                color: Colors.black)
                                          ])),
                                  onTap: () {
                                    setState(() {
                                      utilizador_selecionado = i + 1;

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
                    //Ícones de mensagem e pedidos de amizade
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
                              onPressed: () {
                                /* //Depois adicionar link para a página de pedidos de amizade
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context)=>Pagina_Home())
                                                            );
                                                            */
                              }))
                    ]))
              ])),
          VerticalDivider(width: 1, color: Colors.black),
          Expanded(
              flex: 3,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                if (utilizador_selecionado != 0)
                  if (mensagens[utilizador_selecionado - 1].length == 0)
                    Expanded(
                        //Caso não haja mensagens
                        child: Column(children: [
                      Spacer(),
                      Text("Sem mensagens", style: TextStyle(fontSize: 20))
                    ])),
                if (utilizador_selecionado != 0)
                  if (mensagens[utilizador_selecionado - 1].length != 0)
                    Expanded(
                        //Se tiver mensagens
                        flex: 20,
                        child: ListView.builder(
                            controller: scroll_chat,
                            itemCount:
                                mensagens[utilizador_selecionado - 1].length,
                            itemBuilder: (context, i) {
                              return VerMensagem(
                                  emissor: mensagens[utilizador_selecionado - 1]
                                          [i]
                                      .emissor,
                                  mensagem:
                                      mensagens[utilizador_selecionado - 1][i]
                                          .mensagem,
                                  data: mensagens[utilizador_selecionado - 1][i]
                                      .data);
                            })),
                if (utilizador_selecionado == 0)
                  Expanded(
                      //Tela inicial, quando não tenho amigos ou não cliquei em nenhum amigo, aparece a logo e o Bem vindo
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
                if (utilizador_selecionado != 0)
                  Padding(
                      //Caixa de texto
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                                    width: 400,
                                    child: TextField(
                                        focusNode:
                                            selecionar_caixatexto, //Quando enviar mensagem, para selecionar de novo a caixa de texto automaticamente
                                        controller:
                                            mensagem_enviada, //Variável responsável pela mensagem que vai ser enviada
                                        onSubmitted:
                                            (value) //Se clicar Enter ao enviar a mensagem
                                            {
                                          setState(() {
                                            if (mensagem_enviada
                                                .text.isNotEmpty) {
                                              /*
                                                                                Código de guardar na base de dados a mensagem enviada
                                                                            */
                                              mensagens[utilizador_selecionado -
                                                      1]
                                                  .add(Chat(
                                                      mensagem_enviada.text,
                                                      "Você",
                                                      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year.toString()} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}"));
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
                                                onPressed:
                                                    () //Quando clico na setinha de enviar
                                                    {
                                                  setState(() {
                                                    if (mensagem_enviada
                                                        .text.isNotEmpty) {
                                                      /*
                                                                                        Código de guardar na base de dados a mensagem enviada
                                                                                    */
                                                      mensagens[
                                                              utilizador_selecionado -
                                                                  1]
                                                          .add(Chat(
                                                              mensagem_enviada
                                                                  .text,
                                                              "Você",
                                                              "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year.toString()} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}"));
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
                                onPressed: () {
                                  /*
                                                                Código para terminar sessão
                                                            */
                                  //Depois de terminar sessão, redirecionar para a página de Login
                                  /*Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context)=>Login())
                                                            );*/
                                })
                          ])),
                if (utilizador_selecionado == 0)
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          /*
                                                            Código para terminar sessão
                                                        */
                          //Depois de terminar sessão, redirecionar para a página de Login
                          /*Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context)=>Login())
                                                        );*/
                        })
                  ])
              ]))
        ])));
  }
}

class VerMensagem extends StatelessWidget {
  final String emissor;
  final String mensagem;
  final String data;

  const VerMensagem(
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
