import 'package:flutter/material.dart';

class CadastrarTreinoState {
  bool isLoading;
  bool isSucesso;
  String mensagem;
  final GlobalKey<FormState> formKey;
  final TextEditingController horarioController;
  final TextEditingController descricaoController;

  CadastrarTreinoState(
    this.isLoading,
    this.isSucesso,
    this.mensagem,
    this.formKey,
    this.horarioController,
    this.descricaoController,
  );

}