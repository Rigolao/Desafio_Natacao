import 'package:flutter/material.dart';

class LoginState {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController senhaController;
  String email;
  String password;
  bool showPassword;
  String error;
  TextEditingController? emailEsqueciMinhaSenhaController;

  LoginState(
    this.formKey,
    this.emailController,
    this.senhaController,
    this.email,
    this.password,
    this.showPassword,
    this.error
  );
}
