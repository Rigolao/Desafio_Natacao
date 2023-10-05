import 'package:desafio_6_etapa/atletas_treino/atletas_treino_content.dart';
import 'package:desafio_6_etapa/cronometro/cronometro_content.dart';
import 'package:desafio_6_etapa/login/login_content.dart';
import 'package:desafio_6_etapa/theme/theme.g.dart';
import 'package:desafio_6_etapa/treino/treino_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_controller.dart';
import 'home/home_content.dart';

void main() {
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
    return MaterialApp(
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
        '/nova': (context) => const CronometroContent(),
      }
    );
  }
}
