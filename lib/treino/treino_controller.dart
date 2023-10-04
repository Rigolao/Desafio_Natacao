import 'package:desafio_6_etapa/atletas_treino/atletas_treino_content.dart';
import 'package:desafio_6_etapa/treino/treino_state.dart';
import 'package:flutter/material.dart';

class TreinoController extends ChangeNotifier {
    final state = TreinoState(1);


    TreinoState get _state => state;

    void participar(BuildContext context) {
        Navigator.of(context).pushReplacementNamed('/treino');
    }
}