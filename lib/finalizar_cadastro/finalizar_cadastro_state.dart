import 'package:flutter/material.dart';

import '../entity/atleta.dart';

class FinalizarCadastroState {
  bool isLoading;
  bool isSucesso;
  String mensagem;

  int currentIndex;
  final List<Widget> pages;
  final Atleta atleta;

  FinalizarCadastroState(this.pages, this.currentIndex, this.atleta, {
    this.isLoading = false,
    this.isSucesso = false,
    this.mensagem = '',
  });
}