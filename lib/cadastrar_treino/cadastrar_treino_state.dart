import 'package:flutter/material.dart';

import '../entity/treino.dart';

class CadastrarTreinoState {
  bool isLoading;
  bool isSucesso;
  String mensagem;
  final GlobalKey<FormState> formKey;
  final TextEditingController horarioController;
  final TextEditingController descricaoController;
  Treino? treino;

  CadastrarTreinoState({
    required this.formKey,
    required this.horarioController,
    required this.descricaoController,
    this.isLoading = true,
    this.isSucesso = false,
    this.mensagem = ''
  });

}