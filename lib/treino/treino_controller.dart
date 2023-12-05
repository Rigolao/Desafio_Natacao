import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:desafio_6_etapa/entity/treino.dart';
import 'package:desafio_6_etapa/treino/treino_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';

class TreinoController extends ChangeNotifier {
  final state = TreinoState();

  TreinoState get _state => state;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  void inicializar(BuildContext context) {
    if (_state.isLoading) {
      _firebaseFirestore.collection('treinos').get().then((value) {
        _state.treinos = List.empty();

        List<Treino> treinos = value.docs
            .map((e) => Treino.fromJson(e.data() as Map<String, dynamic>))
            .toList();

        List<Treino> treinosValidos = [];

        for (var element in treinos) {
          if (!isDatePassed(element.horario)) {
            treinosValidos.add(element);
          }
        }

        _state.treinos = treinosValidos;

        _state.isLoading = false;
        notifyListeners();
      }).catchError((error) {
        _state.isLoading = false;
        _state.mensagem = 'Erro ao buscar treinos: $error';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_state.mensagem),
            duration: const Duration(seconds: 2),
          ),
        );

        notifyListeners();
      });
    }
  }

  void participar(BuildContext context, Treino treino) {
    final AppController appController =
    Provider.of<AppController>(context, listen: false);
    appController.setTreinoSelecionado(treino);

    Navigator.of(context).pushNamed('/treino');
  }

  void excluirTreino(BuildContext context, int index, Treino treino) {
    String uuidDoTreinoParaExcluir = treino.UUID;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text('Tem certeza de que deseja excluir este treino?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                CollectionReference treinosRef =
                    _firebaseFirestore.collection('treinos');

                treinosRef
                    .where('UUID', isEqualTo: uuidDoTreinoParaExcluir)
                    .get()
                    .then((querySnapshot) {
                  if (querySnapshot.docs.isNotEmpty) {
                    var documentoParaExcluir = querySnapshot.docs.first;

                    documentoParaExcluir.reference.delete().then((value) {
                      _state.treinos.removeAt(index);

                      _state.mensagem = 'Treino excluido com sucesso!';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_state.mensagem),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      notifyListeners();
                    }).catchError((error) {
                      _state.mensagem = 'Erro ao excluir treino: $error';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_state.mensagem),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      notifyListeners();
                    });
                  } else {
                    _state.mensagem =
                        'Treino com UUID $uuidDoTreinoParaExcluir não encontrado.';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_state.mensagem),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    notifyListeners();
                  }
                });
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void editarTreino(BuildContext context, Treino treino) {
    final AppController appController =
        Provider.of<AppController>(context, listen: false);
    appController.setTreinoSelecionado(treino);

    Navigator.of(context).pushNamed('/cadastrar-treino').then((_) {
      () => inicializar;
      notifyListeners();
    });
  }

  bool isTreinador(BuildContext context) {
    final AppController appController =
        Provider.of<AppController>(context, listen: false);

    return appController.state.usuario!.tipoUsuario == TipoUsuario.TREINADOR;
  }

  bool isDatePassed(String dateString) {
    try {
      DateTime now = DateTime.now();
      DateTime dateTime = DateFormat("dd/MM/yyyy HH:mm").parse(dateString);

      return now.isAfter(dateTime);
    } catch (e) {
      print('Erro ao analisar a data/hora: $e');
      return false;
    }
  }
}
