import 'package:desafio_6_etapa/atletas_treino/atletas_treino_content.dart';
import 'package:desafio_6_etapa/treino/treino_state.dart';
import 'package:flutter/material.dart';

class TreinoController extends ChangeNotifier {
    final state = TreinoState();


    TreinoState get _state => state;

    void inicializar(BuildContext context) {
        Future.delayed(const Duration(seconds: 1)).then((value) {
            state.isLoading = false;
            notifyListeners();
        });
    }

    void participar(BuildContext context) {
        Navigator.of(context).pushNamed('/treino');
    }
}