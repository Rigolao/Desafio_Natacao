import 'package:flutter/material.dart';

import 'atletas_treino_state.dart';

class AtletasTreinoController extends ChangeNotifier{
    final state = AtletasTreinoState();

    AtletasTreinoState get _state => state;

    void voltar(BuildContext context) {
        Navigator.of(context).pop();
    }
}