import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cadastrar_treino_state.dart';

class CadastrarTreinoController extends ChangeNotifier {
  final state = CadastrarTreinoState(
    formKey: GlobalKey<FormState>(),
    horarioController: TextEditingController(),
    descricaoController: TextEditingController(),
  );

  CadastrarTreinoState get _state => state;

  void cadastrarTreino() {
    if (_state.formKey.currentState!.validate()) {
      _state.isLoading = true;
      notifyListeners();
      Future.delayed(Duration(seconds: 2), () {
        _state.isLoading = false;
        _state.isSucesso = true;
        _state.mensagem = 'Treino cadastrado com sucesso!';
        notifyListeners();
      });
    }
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

        final formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime);

        _state.horarioController.text = formattedDateTime;
      }
    }
    notifyListeners();
  }
}
