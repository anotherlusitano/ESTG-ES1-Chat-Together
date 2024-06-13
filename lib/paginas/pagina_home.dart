import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

class PaginaHome extends StatefulWidget {
  const PaginaHome({Key? key}) : super(key: key);

  @override
  PaginaHomeEstado createState() => PaginaHomeEstado();
}

class PaginaHomeEstado extends State<PaginaHome> {
  int quantidade_pedidos = 12;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat Together",
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  if (quantidade_pedidos == 0)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Nenhum convite", style: TextStyle(fontSize: 20))
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: quantidade_pedidos,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              Container(
                                color: Colors.grey[200],
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(""),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.check,
                                              color: Colors.green),
                                          onPressed: () {}),
                                      IconButton(
                                          icon: Icon(Icons.close,
                                              color: Colors.red),
                                          onPressed: () {})
                                    ],
                                  ),
                                ),
                              ),
                              Divider(height: 1, color: Colors.black)
                            ],
                          );
                        },
                      ),
                    ),
                  Divider(height: 1, color: Colors.black),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: IconButton(
                                iconSize: 50,
                                icon: Icon(Icons.message, color: Colors.black),
                                onPressed: () {})),
                        Expanded(
                            child: IconButton(
                                iconSize: 50,
                                icon: Icon(Icons.email, color: Colors.blue),
                                onPressed: () {}))
                      ],
                    ),
                  )
                ],
              ),
            ),
            VerticalDivider(width: 1, color: Colors.black),
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
                  Text("Vem chattar connosco!", style: TextStyle(fontSize: 24)),
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
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintText: "Adicionar o teu amigo aqui",
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.add_circle),
                                    onPressed: () {}),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          iconSize: 40,
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
