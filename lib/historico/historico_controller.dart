import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import '../entity/treino.dart';
import 'historico_state.dart';

class HistoricoController extends ChangeNotifier {
  final HistoricoState state = HistoricoState();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void inicializar(BuildContext context) {
    if(state.isLoading) {
      _firebaseFirestore.collection('treinos').get().then((value) {
        state.treinos = List.empty();

        List<Treino> treinos = value.docs.map((e) => Treino.fromJson(e.data())).toList();

        List<Treino> treinosValidos = [];

        for (var element in treinos) {
          if (!isDateAfter(element.horario)) {
            treinosValidos.add(element);
          }
        }

        state.treinos = treinosValidos;

        state.isLoading = false;
        notifyListeners();
      }).catchError((error) {
        state.isLoading = false;
        state.error = 'Erro ao buscar treinos: $error';

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

  void navegarParaResultadoTreino(BuildContext context, Treino treino) {
    final AppController appController = Provider.of<AppController>(
        context, listen: false);

    appController.setTreinoSelecionado(treino);

    Navigator.of(context).pushNamed('/atleta-treino');
  }

  bool isDateAfter(String dateString) {
    try {
      DateTime now = DateTime.now();
      DateTime dateTime = DateFormat("dd/MM/yyyy HH:mm").parse(dateString);

      return now.isBefore(dateTime);
    } catch (e) {
      print('Erro ao analisar a data/hora: $e');
      return false;
    }
  }
}