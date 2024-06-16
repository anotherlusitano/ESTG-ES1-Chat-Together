import "package:chat_together/widgets/item_amigo.dart";
import "package:chat_together/widgets/mensagens.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class Pagina extends StatefulWidget {
  const Pagina({super.key});

  @override
  PaginaEstado createState() => PaginaEstado();
}

class PaginaEstado extends State<Pagina> {
  TextEditingController mensagemEnviada = TextEditingController();
  FocusNode selecionarCaixatexto = FocusNode();
  final _amigoSelecionado = "quero um 20";
  bool _selecionado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                if (_amigoSelecionado.isEmpty)
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sem amigos",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          child: ItemAmigo(
                            username: _amigoSelecionado,
                            utilizadorSelecionado: _amigoSelecionado,
                            selecionado: _selecionado,
                          ),
                          onTap: () => setState(
                            () {
                              _selecionado = !_selecionado;
                            },
                          ),
                        ),
                        GestureDetector(
                          child: ItemAmigo(
                            username: "loias",
                            utilizadorSelecionado: _amigoSelecionado,
                            selecionado: _selecionado,
                          ),
                          onTap: () => setState(
                            () {
                              _selecionado = !_selecionado;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.message, color: Colors.blue),
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.email, color: Colors.black),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1, color: Colors.black),
          Expanded(
            flex: 3,
            child: _amigoSelecionado.isNotEmpty
                ? Column(
                    children: [
                      // const Expanded(
                      //   child: Column(
                      //     children: [
                      //       Spacer(),
                      //       Text(
                      //         "Sem mensagens",
                      //         style: TextStyle(fontSize: 20),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Mensagem(
                        emissor: _amigoSelecionado,
                        utilizadorSelecionado: _amigoSelecionado,
                        mensagem: "lol",
                        data: "1999-12-13:21:21:21",
                      ),
                      Mensagem(
                        emissor: "lol=",
                        utilizadorSelecionado: _amigoSelecionado,
                        mensagem: "lol",
                        data: "1999-12-13:21:21:21",
                      ),
                      Mensagem(
                        emissor: _amigoSelecionado,
                        utilizadorSelecionado: _amigoSelecionado,
                        mensagem:
                            "Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet. Nisi anim cupidatat excepteur officia. Reprehenderit nostrud nostrud ipsum Lorem est aliquip amet voluptate voluptate dolor minim nulla est proident. Nostrud officia pariatur ut officia. Sit irure elit esse ea nulla sunt ex occaecat reprehenderit commodo officia dolor Lorem duis laboris cupidatat officia voluptate. Culpa proident adipisicing id nulla nisi laboris ex in Lorem sunt duis officia eiusmod. Aliqua reprehenderit commodo ex non excepteur duis sunt velit enim. Voluptate laboris sint cupidatat ullamco ut ea consectetur et est culpa et culpa duis.",
                        data: "1999-12-13:21:21:21",
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 400,
                                child: TextField(
                                  focusNode: selecionarCaixatexto,
                                  controller: mensagemEnviada,
                                  onSubmitted: (value) {},
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    hintText: "Enviar mensagem",
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.send),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              iconSize: 40,
                              icon: const Icon(Icons.logout),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/chat-together-icon.png",
                                width: 200,
                                height: 200,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Bem-vindo!",
                                style: TextStyle(fontSize: 24),
                              ),
                              const Text(
                                "Vem chattar connosco!",
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 40,
                            icon: const Icon(Icons.logout),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
