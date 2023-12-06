import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/atleta_historico/atleta_historico_state.dart';
import 'package:desafio_6_etapa/entity/avaliacao.dart';
import 'package:desafio_6_etapa/entity/usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import '../entity/treino.dart';

class AtletaHistoricoController extends ChangeNotifier {
  final AtletaHistoricoState state = AtletaHistoricoState();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void inicializar(BuildContext context) {
    if (state.isLoading) {
      final AppController appController =
          Provider.of<AppController>(context, listen: false);

      Usuario? usuario = appController.state.usuario;
      Treino? treino = appController.state.treinoSelecionado;

      debugPrint(appController.state.usuario.toString());
      debugPrint(appController.state.treinoSelecionado.toString());

      _firebaseFirestore
          .collection('avaliacoes')
          .where('treinoUUID', isEqualTo: treino?.UUID)
          .where('atletaUUID', isEqualTo: usuario?.id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          debugPrint('Avaliação encontrada');
          state.avaliacao = Avaliacao.fromJson(value.docs.first.data());
        }

        state.isLoading = false;
        notifyListeners();
      }).catchError((error) {
        state.isLoading = false;
        state.error = 'Erro ao buscar avaliação: $error';

        debugPrint(error.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
            duration: const Duration(seconds: 2),
          ),
        );

        notifyListeners();
      });
    }
  }
}
