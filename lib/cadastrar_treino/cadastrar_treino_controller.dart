import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/entity/treino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import '../treino/treino_controller.dart';
import 'cadastrar_treino_state.dart';

class CadastrarTreinoController extends ChangeNotifier {
  final state = CadastrarTreinoState(
    formKey: GlobalKey<FormState>(),
    horarioController: TextEditingController(),
    descricaoController: TextEditingController(),
  );

  CadastrarTreinoState get _state => state;

  void inicializar(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_state.isLoading) {
        _state.isLoading = false;

        final AppController appController =
            Provider.of<AppController>(context, listen: false);

        if (appController.state.treinoSelecionado != null) {
          _state.treino = appController.state.treinoSelecionado;
          _state.descricaoController.text =
              appController.state.treinoSelecionado!.descricao;
          _state.horarioController.text =
              appController.state.treinoSelecionado!.horario;
        }

        notifyListeners();
      }
    });
  }

  void cadastrarTreino(BuildContext context, Function fetchTreinos) {
    if (_state.formKey.currentState!.validate()) {
      final AppController appController =
          Provider.of<AppController>(context, listen: false);

      if (appController.state.treinoSelecionado != null) {
        atualizarTreino(context, appController.state.treinoSelecionado!, fetchTreinos);
      } else {
        salvarTreino(context, fetchTreinos);
      }
    }
  }

  void salvarTreino(BuildContext context, Function fetchTreinos) {
    final AppController appController =
    Provider.of<AppController>(context, listen: false);

    Treino treino = Treino(
        descricao: _state.descricaoController.text,
        horario: _state.horarioController.text,
        treinadorUUID: appController.state.usuario!.id!,
        treinador: appController.state.usuario!.nome);

    var db = FirebaseFirestore.instance;
    _state.isLoading = true;
    notifyListeners();

    db.collection('treinos').doc().set(treino.toJson()).then((value) {
      _state.isLoading = false;
      _state.isSucesso = true;
      _state.mensagem = 'Treino cadastrado com sucesso!';

      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_state.mensagem),
          duration: Duration(seconds: 2),
        ),
      );

      fetchTreinos();

      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

      TreinoController treinoController =
          Provider.of<TreinoController>(context, listen: false);
      treinoController.inicializar(context);
    }).catchError((error) {
      _state.isLoading = false;
      _state.isSucesso = false;
      _state.mensagem = 'Erro ao cadastrar treino: $error';

      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao cadastrar treino: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  void atualizarTreino(BuildContext context, Treino treino, Function fetchTreinos) {
    treino.descricao = _state.descricaoController.text;
    treino.horario = _state.horarioController.text;

    var db = FirebaseFirestore.instance;
    _state.isLoading = true;

    db
        .collection('treinos')
        .where('UUID', isEqualTo: treino.UUID)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var documentoParaAtualizar = querySnapshot.docs.first.reference;

        documentoParaAtualizar.update({
          'descricao': treino.descricao,
          'horario': treino.horario,
        }).then((_) {
          _state.isLoading = false;
          _state.isSucesso = true;
          _state.mensagem = 'Treino atualizado com sucesso!';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_state.mensagem),
              duration: Duration(seconds: 2),
            ),
          );

          final AppController appController =
              Provider.of<AppController>(context, listen: false);
          appController.setTreinoSelecionado(null);

          notifyListeners();

          Navigator.pop(context);

          fetchTreinos();
        }).catchError((error) {
          _state.isLoading = false;
          _state.isSucesso = false;
          _state.mensagem = 'Erro ao atualizar treino: $error';

          notifyListeners();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_state.mensagem),
              duration: Duration(seconds: 2),
            ),
          );
        });
      } else {
        _state.isLoading = false;
        _state.isSucesso = false;
        _state.mensagem = 'Treino com UUID ${treino.UUID} não encontrado.';

        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_state.mensagem),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }).catchError((error) {
      _state.isLoading = false;
      _state.isSucesso = false;
      _state.mensagem = 'Erro ao buscar treino: $error';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_state.mensagem),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  Future<void> selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final formattedDateTime =
            DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime);

        _state.horarioController.text = formattedDateTime;
      }
    }
    notifyListeners();
  }
}
