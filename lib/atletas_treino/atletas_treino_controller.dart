import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import 'atletas_treino_state.dart';

class AtletasTreinoController extends ChangeNotifier{
    final state = AtletasTreinoState();

    AtletasTreinoState get _state => state;

    void inicializar(BuildContext context) async {
        if(_state.isLoading) {
            final AppController appController = Provider.of<AppController>(context, listen: false);
            state.treino = appController.state.treinoSelecionado;
        }
    }

    void voltar(BuildContext context) {
        Navigator.of(context).pop();
    }
}