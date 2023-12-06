import 'package:desafio_6_etapa/atleta_historico/atleta_historico_content.dart';
import 'package:desafio_6_etapa/atletas_treino/atletas_treino_content.dart';
import 'package:desafio_6_etapa/cadastrar_treino/cadastrar_treino_content.dart';
import 'package:desafio_6_etapa/cronometro/cronometro_content.dart';
import 'package:desafio_6_etapa/entity/usuario.dart';
import 'package:desafio_6_etapa/firebase_options.dart';
import 'package:desafio_6_etapa/historico/historico_content.dart';
import 'package:desafio_6_etapa/login/login_content.dart';
import 'package:desafio_6_etapa/theme/theme.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_controller.dart';
import 'cadastrar_usuario/cadastrar_usuario_content.dart';
import 'home/home_content.dart';
import 'home/home_controller.dart';

void  main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.ios
  );

  runApp(ChangeNotifierProvider(
    create: (context) => AppController(),
    builder: (context, child) {
      return const MyApp();
    }
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => AppController()),
      ],
      child: MaterialApp(
        title: 'Natação Unaerp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: lightColorScheme,
          useMaterial3: true,
        ),
        home: const LoginContent(),
        routes: {
          '/login': (context) => const LoginContent(),
          '/home': (context) => const HomeContent(),
          '/treino': (context) => const AtletaTreinoContent(),
          '/cadastrar-usuario': (context) => const CadastrarUsuarioContent(),
          '/cadastrar-treino': (context) => CadastrarTreinoContent(fetchTreinos: () {}),
          '/cronometro': (context) => CronometroContent(ritmoInicial: "" ),
          '/historico': (context) => const HistoricoContent(),
          '/atleta-treino': (context) => const AtletaHistoricoContent(),
        }
      ),
    );
  }
}
