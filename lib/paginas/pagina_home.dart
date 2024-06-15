import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:gaming_together/widgets/snack_message.dart";

class PaginaHome extends StatefulWidget {
  const PaginaHome({Key? key}) : super(key: key);

  @override
  PaginaHomeEstado createState() => PaginaHomeEstado();
}

class PaginaHomeEstado extends State<PaginaHome> {
  final currentUser = FirebaseAuth.instance.currentUser;
  late final userCollection = FirebaseFirestore.instance.collection('Utilizadores').doc(currentUser!.uid);

  final _inviteController = TextEditingController();

  enviarConvite() {
    if (_inviteController.text.isNotEmpty) {
      String username = _inviteController.text;

      FirebaseFirestore.instance.collection('Utilizadores').where("username", isEqualTo: username).get().then(
        (value) async {
          // verifica se o utilizador é amigo
          if (value.docs[0]['amigos'].contains(currentUser!.uid)) {
            return SnackMsg.showInfo(context, 'Este utilizador já é teu amigo!');
          }
          // verifica se o utilizador tem o convite
          else if (value.docs[0]['convites'].contains(currentUser!.uid)) {
            return SnackMsg.showInfo(context, 'Este utilizador já tem um convite');
          } else {
            // envia o convite para o utilizador
            FirebaseFirestore.instance.collection('Utilizadores').doc(value.docs[0].id).update({
              'convites': FieldValue.arrayUnion([currentUser!.uid]),
            });
            return SnackMsg.showOk(context, 'Convite enviado!');
          }
        },
      ).catchError((error) {
        if (error.toString() == 'RangeError (index): Index out of range: no indices are valid: 0') {
          SnackMsg.showError(context, 'Utilizador não existe!');
        } else {
          SnackMsg.showError(context, 'Ocorreu um erro: $error');
        }
      });
    } else {
      SnackMsg.showError(context, 'O username não pode ser vazio!');
    }

    setState(() {
      _inviteController.clear();
    });
  }

  aceitarConvite(String userId) {
    userCollection.update({
      "amigos": FieldValue.arrayUnion([userId])
    });

    userCollection.update({
      "convites": FieldValue.arrayRemove([userId])
    });

    FirebaseFirestore.instance.collection('Utilizadores').doc(userId).update({
      "amigos": FieldValue.arrayUnion([currentUser!.uid])
    });

    FirebaseFirestore.instance.collection('Utilizadores').doc(userId).update({
      "convites": FieldValue.arrayRemove([currentUser!.uid])
    });

    return SnackMsg.showOk(context, 'Amigo adicionado com sucesso!');
  }

  rejeitarConvite(String userId) {
    userCollection.update({
      "convites": FieldValue.arrayRemove([userId])
    });

    return SnackMsg.showOk(context, 'Convite rejeitado com sucesso!');
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
                    stream: userCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final listaConvites = snapshot.data!['convites'] as List<dynamic>;

                        if (listaConvites.isEmpty) {
                          return const Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Nenhum convite",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ));
                        }
                        return Expanded(
                          child: ListView.builder(
                              itemCount: listaConvites.length,
                              itemBuilder: (context, i) {
                                return FutureBuilder<DocumentSnapshot>(
                                  future:
                                      FirebaseFirestore.instance.collection('Utilizadores').doc(listaConvites[i].toString().trim()).get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                      final username = snapshot.data!['username'];

                                      return Column(
                                        children: [
                                          Container(
                                            color: Colors.grey[200],
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: ListTile(
                                              title: Text(username),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.check, color: Colors.green),
                                                    onPressed: () => aceitarConvite(listaConvites[i]),
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(Icons.close, color: Colors.red),
                                                    onPressed: () => rejeitarConvite(listaConvites[i]),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Divider(height: 1, color: Colors.black)
                                        ],
                                      );
                                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Deu este erro: ${snapshot.error}');
                                    }

                                    return const SizedBox.shrink();
                                  },
                                );
                              }),
                        );
                      } else {
                        return const Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Nenhum convite",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ));
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.message, color: Colors.black),
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.email, color: Colors.blue),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.black),
          const VerticalDivider(width: 1, color: Colors.black),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset("assets/chat-together-icon.png", width: 200, height: 200),
                const SizedBox(height: 10),
                const Text("Bem-vindo!", style: TextStyle(fontSize: 24)),
                const Text("Vem chattar connosco!", style: TextStyle(fontSize: 24)),
                const Spacer(),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Adicionar", style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          width: 400,
                          child: TextField(
                            controller: _inviteController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: "Adicionar o teu amigo aqui",
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.add_circle),
                                onPressed: () => enviarConvite(),
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
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
