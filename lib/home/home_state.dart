import 'package:flutter/material.dart';

import '../entity/usuario.dart';

class HomeState {
  bool isLoading = true;
  bool isSucesso = false;
  String mensagem = '';
  String title;
  int currentIndex;
  final List<Widget> pages;
  List<Usuario> usuarios;
  HomeState(this.title, this.currentIndex, this.pages, this.usuarios);
}