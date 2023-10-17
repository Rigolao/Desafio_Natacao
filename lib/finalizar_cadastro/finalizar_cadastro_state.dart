import 'package:flutter/material.dart';

import '../entity/atleta.dart';

class FinalizarCadastroState {
  bool isLoading;
  bool isSucesso;
  String mensagem;
  final TextEditingController dataController = TextEditingController();
  final TextEditingController naturalidadeController = TextEditingController();
  final TextEditingController nacionalidadeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController rgController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController nomePaiController = TextEditingController();
  final TextEditingController nomeMaeController = TextEditingController();
  final TextEditingController clubeOrigemController = TextEditingController();
  final TextEditingController empresaTrabalhaController = TextEditingController();
  final TextEditingController cvmController = TextEditingController();
  final TextEditingController alergiaController = TextEditingController();
  final TextEditingController estController = TextEditingController();
  final TextEditingController pvrController = TextEditingController();
  String atestadoController = '';

  int currentIndex;
  final List<Widget> pages;
  final Atleta atleta;

  FinalizarCadastroState(this.pages, this.currentIndex, this.atleta, {
    this.isLoading = false,
    this.isSucesso = false,
    this.mensagem = '',
  });
}