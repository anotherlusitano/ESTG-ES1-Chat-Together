import "package:flutter/material.dart";
//import ""; //Página Login
//import ""; //Página Mensagens

void main() {
  runApp(Pagina_Home());
}

class Pagina_Home extends StatefulWidget {
  const Pagina_Home({Key? key}) : super(key: key);

  @override
  Pagina_HomeEstado createState() => Pagina_HomeEstado();
}

class Pagina_HomeEstado extends State<Pagina_Home> {
  int quantidade_utilizadores = 12;
  //A quantidade de nomes inseridos dentro desta lista tem de estar de acordo com a variável quantidade_utilizadores
  //Esta lista de utilizadores são exemplos, que vai ser aqui depois adicionar o código para ser lista de pedidos de amizades da base de dados
  final List<String> utilizadores = [
    "antonuolink",
    "ToacyVaiMeDar20",
    "MrEstudador",
    "Afonso295",
    "Cellbit",
    "SigmaMale",
    "5ugg4rM0mmy",
    "AmanteN21DoAntonio",
    "Bill_Gates",
    "iShowSpeed",
    "_Obama_",
    "JohanLiebert2817"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Chat Together",
        home: Scaffold(
            body: Row(children: [
          Expanded(
              //O código dentro deste Expanded é a parte esquerda
              flex: 1,
              child: Column(children: [
                if (quantidade_utilizadores == 0)
                  Expanded(
                      //O código dentro deste Expanded é caso não haja pedidos de amizades
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Text("Nenhum convite", style: TextStyle(fontSize: 20))
                      ]))
                else
                  Expanded(
                      //O código dentro deste Expanded é a parte do código em que aparece a lista de pedidos de amizade
                      child: ListView.builder(
                          itemCount: quantidade_utilizadores,
                          itemBuilder: (context, i) {
                            return Column(children: [
                              Container(
                                  color: Colors.grey[200],
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                      title: Text(utilizadores[i]),
                                      trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.check,
                                                    color: Colors.green),
                                                onPressed: () {
                                                  setState(() {
                                                    /*
                                                                                        Código de adicionar amigo na Base de dados
                                                                                        E remover pedido de amizades na Base de Dados
                                                                                    */
                                                    //Remover pedido de amizade da tela
                                                    quantidade_utilizadores--;
                                                    utilizadores.removeAt(i);
                                                  });
                                                }),
                                            IconButton(
                                                icon: Icon(Icons.close,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  setState(() {
                                                    /*
                                                                                        Código de remover pedido de amizades na Base de Dados
                                                                                    */
                                                    //Remover pedido de amizade da tela
                                                    quantidade_utilizadores--;
                                                    utilizadores.removeAt(i);
                                                  });
                                                })
                                          ]))),
                              Divider(height: 1, color: Colors.black)
                            ]);
                          })),
                Divider(height: 1, color: Colors.black),
                Padding(
                    //O código dentro deste Padding são os botões de Mensagens e Pedidos
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(children: [
                      Expanded(
                          child: IconButton(
                              iconSize: 50,
                              icon: Icon(Icons.message, color: Colors.black),
                              onPressed: () {
                                /* //Depois adicionar link para a página do chat com mensagens
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context)=>Mensagens())
                                                            );
                                                            */
                              })),
                      Expanded(
                          child: IconButton(
                              iconSize: 50,
                              icon: Icon(Icons.email, color: Colors.blue),
                              onPressed: () {}))
                    ]))
              ])),
          VerticalDivider(width: 1, color: Colors.black),
          Expanded(
              //O código dentro Expanded já é a parte normal do site, com a logo, o Bem-vindo e isso tudo
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
                    Spacer(),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Adicionar", style: TextStyle(fontSize: 20)),
                              SizedBox(width: 20),
                              Expanded(
                                  child: Container(
                                      width: 400,
                                      child: TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              hintText:
                                                  "Adicionar o teu amigo aqui",
                                              suffixIcon: IconButton(
                                                  icon: Icon(Icons.add_circle),
                                                  onPressed: () {
                                                    /*
                                                                            Código para adicionar pedidos de amizades na base de dados
                                                                        */
                                                    //Mensagem de confirmação que o pedido de amizade foi enviado com sucesso
                                                    /*showDialog(
                                                                            context: context,
                                                                            builder: (BuildContext context)
                                                                            {
                                                                                return AlertDialog(
                                                                                    content: Text("Mensagem enviada com sucesso!", style: TextStyle(fontSize: 20)),
                                                                                    actions: <Widget>[
                                                                                        TextButton(
                                                                                            onPressed: ()
                                                                                            {
                                                                                                Navigator.of(context).pop();
                                                                                            },
                                                                                            child: Text('Fechar', style: TextStyle(fontSize: 20)),
                                                                                        ),
                                                                                    ]
                                                                                );
                                                                            }
                                                                        );*/
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
                            ]))
                  ]))
        ])));
  }
}
