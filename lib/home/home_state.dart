import 'package:flutter/material.dart';

import '../entity/usuario.dart';

class HomeState {
  String title;
  int currentIndex;
  final List<Widget> pages;
  final Usuario usuario;

  HomeState(this.title, this.currentIndex, this.pages, this.usuario);
}