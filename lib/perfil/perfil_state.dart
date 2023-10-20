import 'package:desafio_6_etapa/entity/usuario.dart';
import 'package:flutter/cupertino.dart';

class PerfilState {
  bool isLoading;
  bool isEditing;
  String error;
  bool showPassword;
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController emailController;
  final TextEditingController senhaController;
  Usuario usuario;

  PerfilState({
    this.isLoading = true,
    this.isEditing = false,
    this.error = '',
    this.showPassword = false,
    required this.usuario,
    required this.formKey,
    required this.nomeController,
    required this.emailController,
    required this.senhaController,
  });
}