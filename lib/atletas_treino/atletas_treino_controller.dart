import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import '../entity/usuario.dart';
import 'atletas_treino_state.dart';

class AtletasTreinoController extends ChangeNotifier{
    final state = AtletasTreinoState();

    AtletasTreinoState get _state => state;

    void inicializar(BuildContext context) async {
        if (_state.isLoading) {
            final AppController appController =
            Provider.of<AppController>(context, listen: false);
            _state.treino = appController.state.treinoSelecionado;

            var db = FirebaseFirestore.instance;

            var avaliacoesQuery = await db.collection('avaliacoes')
                .where('treinoUUID', isEqualTo: _state.treino!.UUID).get();
            List<String> usuariosComAvaliacoes =
            avaliacoesQuery.docs.map((e) => e['atletaUUID'].toString()).toList();

            var atletasQuery = await db
                .collection('usuarios')
                .where('tipoUsuario', isEqualTo: 'ATLETA')
                .get();

            _state.atletas = atletasQuery.docs
                .where((e) => !usuariosComAvaliacoes.contains(e.id))
                .map((e) => Usuario.fromMap(e.data(), e.id))
                .toList();

            _state.isLoading = false;
            notifyListeners();
        }
    }


    void voltar(BuildContext context) {
        Navigator.of(context).pop();
    }
}