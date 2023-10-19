import 'package:flutter/material.dart';

class CadastrarTreinoState {
  bool isLoading;
  bool isSucesso;
  String mensagem;
  final GlobalKey<FormState> formKey;
  final TextEditingController horarioController;
  final TextEditingController descricaoController;

  CadastrarTreinoState(
  {required this.formKey,
      required this.horarioController,
      required this.descricaoController,
      this.isLoading = false,
      this.isSucesso = false,
      this.mensagem = ''}
  );

}