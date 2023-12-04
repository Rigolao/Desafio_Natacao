import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:desafio_6_etapa/home/home_content.dart';
import 'package:desafio_6_etapa/login/login_content.dart';
import 'package:desafio_6_etapa/util/converter.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


main () {
  test('Teste de converção', () {
   expect(ConversorEnum.converterStringParaEnum('ADMINISTRADOR'), equals(TipoUsuario.ADMINISTRADOR));
   expect(ConversorEnum.converterEnumParaString(TipoUsuario.ADMINISTRADOR), equals('ADMINISTRADOR'));
  });

  test('Teste de criação de usúario',() async {

    final firestore = MockFirebaseAuth();
    final credencial = await firestore.createUserWithEmailAndPassword(email: 'bob@gmail.com', password: '12345678910');

    expect(credencial.user?.email, 'bob@gmail.com');

  });

  testWidgets('teste de integração',(tester) async {

    await tester.pumpWidget(const MaterialApp(
        home: Material(
            child: LoginContent()
        )
    ));

    Finder emailTextField = find.widgetWithText(TextFormField, 'E-mail');
    Finder senhaTextField = find.widgetWithText(TextFormField, 'Senha');
    Finder buttonFinder = find.byType(FilledButton);

    await tester.enterText(emailTextField, 'desafio6etapa@gmail.com');
    await tester.enterText(senhaTextField, 'joao123');
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(HomeContent), findsOneWidget);

  });
}