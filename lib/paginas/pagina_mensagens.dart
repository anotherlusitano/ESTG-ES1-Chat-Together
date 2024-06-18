import "package:chat_together/paginas/pagina_home.dart";
import "package:chat_together/paginas/pagina_login.dart";
import "package:chat_together/provedor.dart";
import "package:chat_together/widgets/item_amigo.dart";
import "package:chat_together/widgets/mensagens.dart";
import "package:chat_together/widgets/snack_message.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

class PaginaMensagens extends StatefulWidget {
  const PaginaMensagens({super.key});

  @override
  PaginaEstado createState() => PaginaEstado();
}

class PaginaEstado extends State<PaginaMensagens> {
  TextEditingController mensagemEnviada = TextEditingController();
  final tabelaUtilizadores = FirebaseFirestore.instance.collection('Utilizadores');
  final tabelaConversas = FirebaseFirestore.instance.collection('Conversas');
  final currentUser = FirebaseAuth.instance.currentUser;
  FocusNode selecionarCaixatexto = FocusNode();
  String _idAmigoSelecionado = "";
  String _amigoSelecionado = "";
  String idConversa = "";
  bool _selecionado = false;

  void mandarMensagem() async {
    if (mensagemEnviada.text.trim().isNotEmpty) {
      await FirebaseFirestore.instance.collection('Conversas').doc(idConversa).collection('Mensagens').add({
        'emissor': currentUser!.uid,
        'mensagem': mensagemEnviada.text,
        'timeStamp': Timestamp.now(),
      });
    }

    setState(() {
      mensagemEnviada.clear();
    });
  }

  Future<List<String>> pegarUsernames(String emissorId, String utilizadorId) async {
    var emissorDoc = await tabelaUtilizadores.doc(emissorId).get();
    var utilizadorDoc = await tabelaUtilizadores.doc(utilizadorId).get();

    String emissorx = emissorDoc['username'].toString();
    String utilizadorx = utilizadorDoc['username'].toString();

    return [emissorx, utilizadorx];
  }

  void criarConversa(String idAmigo) {
    final List<String> userIds = [currentUser!.uid, idAmigo];
    userIds.sort();

    tabelaConversas
        .where('utilizador1', isEqualTo: userIds[0])
        .where('utilizador2', isEqualTo: userIds[1])
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        idConversa = querySnapshot.docs[0].id;
        return;
      } else {
        tabelaConversas.add({
          'utilizador1': userIds[0],
          'utilizador2': userIds[1],
        }).then(
          (value) {
            tabelaConversas.doc(value.id).collection('Mensagens').add({
              "inicio": "inicio",
            }).then((_) => null);

            idConversa = value.id;
          },
        ).catchError((error) {
          SnackMsg.showError(context, 'Erro: $error');
        });
      }
    }).catchError((error) {
      SnackMsg.showError(context, 'Erro: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                StreamBuilder(
                  stream: tabelaUtilizadores.doc(currentUser!.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final listaDeAmigos = snapshot.data!['amigos'] as List<dynamic>;

                      return listaDeAmigos.isEmpty
                          ? const Expanded(
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
                          : Expanded(
                              child: ListView.builder(
                                addAutomaticKeepAlives: false,
                                itemCount: listaDeAmigos.length,
                                itemBuilder: (context, index) {
                                  final amigoId = listaDeAmigos[index].toString().trim();

                                  return FutureBuilder<DocumentSnapshot>(
                                    future: tabelaUtilizadores.doc(amigoId).get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                        final username = snapshot.data!['username'];
                                        final idAmigo = snapshot.data!.id;

                                        return GestureDetector(
                                          child: ItemAmigo(
                                            username: username,
                                            utilizadorSelecionado: _amigoSelecionado,
                                            selecionado: _selecionado,
                                          ),
                                          onTap: () => setState(
                                            () {
                                              _selecionado = !_selecionado;
                                              _amigoSelecionado = username;
                                              _idAmigoSelecionado = idAmigo;
                                              criarConversa(idAmigo);
                                            },
                                          ),
                                        );
                                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('Error fetching user data: ${snapshot.error}');
                                      }

                                      return const SizedBox.shrink();
                                    },
                                  );
                                },
                              ),
                            );
                    }
                    return const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sem amigos",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(thickness: 1, color: Colors.black),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PaginaHome()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1, color: Colors.black),
          if (_idAmigoSelecionado.isNotEmpty && idConversa.isNotEmpty)
            StreamBuilder(
              stream: tabelaConversas
                  .doc(idConversa)
                  .collection("Mensagens")
                  .orderBy(
                    'timeStamp',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                return Expanded(
                  flex: 3,
                  child: snapshot.hasData
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  addAutomaticKeepAlives: false,
                                  reverse: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final mensagem = snapshot.data!.docs[index];

                                    final data =
                                        DateTime.fromMillisecondsSinceEpoch(mensagem['timeStamp'].seconds * 1000);
                                    final dataFormatada = DateFormat('dd/MM/yyyy, HH:mm').format(data);

                                    return FutureBuilder<List<String>>(
                                      future: Future.wait([
                                        context.read<UsernamesProvider>().getUsername(mensagem['emissor']),
                                        context.read<UsernamesProvider>().getUsername(currentUser!.uid),
                                      ]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          List<String> usernames = snapshot.data!;

                                          return Mensagem(
                                            emissor: usernames[0],
                                            utilizadorSelecionado: usernames[1],
                                            mensagem: mensagem['mensagem'],
                                            data: dataFormatada,
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    );
                                  }),
                            ),
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
                                            onPressed: () {
                                              mandarMensagem();
                                            },
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PaginaLogin()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Expanded(
                          child: Center(
                            child: Text("Sem mensagens"),
                          ),
                        ),
                );
              },
            )
          else
            Expanded(
              flex: 3,
              child: Column(
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
