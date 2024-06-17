import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_together/paginas/pagina_sign_up.dart';
import 'package:chat_together/widgets/botao_principal.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<BuildContext>()])
void main() {
  testWidgets('Testa se a PaginaSignUp é construída corretamente', (WidgetTester tester) async {
    // Constrói o widget PaginaSignUp e dispara um frame
    await tester.pumpWidget(
      MaterialApp(
        home: PaginaSignUp(),
      ),
    );

    // Verifica se o ícone de voltar está presente
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Verifica se o logo é exibido
    expect(find.byType(Image), findsOneWidget);

    // Verifica se os textos 'Username', 'Email' e 'Password' estão presentes
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verifica se os campos de entrada de texto para username, email e password estão presentes
    expect(find.byType(TextField), findsNWidgets(3));

    // Verifica se o botão de cadastro está presente
    expect(find.byType(BotaoPrincipal), findsOneWidget);
  });

  testWidgets('Testa botão de cadastro e diálogo de carregamento', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PaginaSignUp(),
      ),
    );

    // Insere texto nos campos de username, email e password
    await tester.enterText(find.byType(TextField).at(0), 'testuser');
    await tester.enterText(find.byType(TextField).at(1), 'testuser@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password123');

    // Simula o clique no botão de cadastro
    await tester.tap(find.byType(BotaoPrincipal));
    await tester.pump();

    // Simula a resposta do FirebaseAuth e remove o diálogo de carregamento
    await tester.pumpAndSettle();

    // Verifica se o diálogo de carregamento foi removido
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Testa exibição de mensagem de erro para campo vazio', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PaginaSignUp(),
      ),
    );

    // Deixa os campos de username e password vazios
    await tester.enterText(find.byType(TextField).at(1), 'testuser@example.com');

    // Simula o clique no botão de cadastro
    await tester.tap(find.byType(BotaoPrincipal));
    await tester.pump();

    await tester.pumpAndSettle();
  });

  testWidgets('Testa exibição de mensagem de erro para username existente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PaginaSignUp(),
      ),
    );

    // Insere texto nos campos de username e email
    await tester.enterText(find.byType(TextField).at(0), 'existinguser');
    await tester.enterText(find.byType(TextField).at(1), 'testuser@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password123');

    // Simula o clique no botão de cadastro
    await tester.tap(find.byType(BotaoPrincipal));
    await tester.pump();

    await tester.pumpAndSettle();
  });
}
