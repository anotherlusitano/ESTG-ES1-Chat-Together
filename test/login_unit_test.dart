import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_together/paginas/pagina_login.dart';
import 'package:chat_together/paginas/pagina_sign_up.dart';
import 'package:chat_together/widgets/botao_principal.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';

@GenerateNiceMocks([MockSpec<FirebaseAuth>(), MockSpec<UserCredential>(), MockSpec<User>()])
void main() {
  testWidgets('Testa se a PaginaLogin é construída corretamente', (WidgetTester tester) async {
    // Constrói o widget PaginaLogin e dispara um frame
    await tester.pumpWidget(
      MaterialApp(
        home: PaginaLogin(),
      ),
    );

    // Verifica se o logo é exibido
    expect(find.byType(Image), findsOneWidget);

    // Verifica se os textos 'Email' e 'Password' estão presentes
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verifica se os campos de entrada de texto para username e password estão presentes
    expect(find.byType(TextField), findsNWidgets(2));

    // Verifica se o botão de login está presente
    expect(find.byType(BotaoPrincipal), findsOneWidget);
  });

  testWidgets('Testa visibilidade da senha', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PaginaLogin(),
      ),
    );

    // Inicialmente, a senha deve estar oculta
    TextField passwordField = tester.widget(find.byType(TextField).last);
    expect(passwordField.obscureText, true);

    // Simula o clique no ícone de visibilidade
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();

    // Agora, a senha deve estar visível
    passwordField = tester.widget(find.byType(TextField).last);
    expect(passwordField.obscureText, false);

    // Simula o clique no ícone de visibilidade novamente
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pump();

    // A senha deve estar oculta novamente
    passwordField = tester.widget(find.byType(TextField).last);
    expect(passwordField.obscureText, true);
  });

  testWidgets('Testa botão de login e diálogo de carregamento', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PaginaLogin(),
      ),
    );

    // Insere texto nos campos de username e password
    await tester.enterText(find.byType(TextField).at(0), 'testuser@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
  });

  testWidgets('Testa exibição de mensagem de erro ao falhar login', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PaginaLogin(),
      ),
    );

    // Insere texto nos campos de username e password
    await tester.enterText(find.byType(TextField).at(0), 'wronguser@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');

    // Simula a resposta de falha do FirebaseAuth e remove o diálogo de carregamento
    await tester.pumpAndSettle();
  });
}