import 'package:desafio_6_etapa/entity/usuario.dart';
import 'package:flutter/material.dart';

class CadastrarUsuarioState {
  final formKey = GlobalKey<FormState>();
  Usuario usuario = Usuario(nome: '', email: '', senha: '');
  bool isLoading = false;
  bool isSucesso = false;
  String mensagem = '';
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  CadastrarUsuarioState();
}