import 'dart:async';

import 'package:desafio_6_etapa/perfil/perfil_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import '../entity/usuario.dart';

class PerfilController extends ChangeNotifier {
  final PerfilState state = PerfilState(usuario: Usuario(
    nome: '',
    email: '',
    senha: '',
  ),
  formKey: GlobalKey<FormState>(),
  nomeController: TextEditingController(),
  emailController: TextEditingController(),
  senhaController: TextEditingController(),);

  PerfilState get _state => state;

  void inicializar(BuildContext context) {
    if(_state.isLoading) {
      Timer(const Duration(seconds: 1), () {
        _state.isLoading = false;

        final AppController appController = Provider.of<AppController>(context, listen: false);
        state.usuario = appController.state.usuario!;

        _state.nomeController.text = _state.usuario.nome;
        _state.emailController.text = _state.usuario.email;
        _state.senhaController.text = _state.usuario.senha;

        WidgetsBinding.instance!.addPostFrameCallback((_) {
          notifyListeners();
        });
      });
    }
  }

  void invertIsEditing() {
    _state.isEditing = !_state.isEditing;

    if(!_state.isEditing) {
      _state.nomeController.text = _state.usuario.nome;
      _state.emailController.text = _state.usuario.email;
      _state.senhaController.text = _state.usuario.senha;
      _state.showPassword = false;
    }

    notifyListeners();
  }

  void onLogout(BuildContext context) {
    final appController = Provider.of<AppController>(context, listen: false);
    appController.setUsuario(_state.usuario);

    Navigator.pushReplacementNamed(context, '/login');
  }

  void onEdit(BuildContext context) {
    if (_state.formKey.currentState!.validate()) {
      _state.usuario.nome = _state.nomeController.text;
      _state.usuario.email = _state.emailController.text;
      _state.usuario.senha = _state.senhaController.text;

      final appController = Provider.of<AppController>(context, listen: false);
      appController.setUsuario(_state.usuario);

      _state.showPassword = false;
      _state.isEditing = false;
      _state.isLoading = true;

      notifyListeners();
    }
  }

  void onShowPassword() {
    _state.showPassword = !_state.showPassword;
    notifyListeners();
  }

  String? validatePassword(String? value) {
    if(value == null || value.isEmpty || value == '') {
      return 'Informe a senha';
    }

    _state.senhaController.text = value;
    notifyListeners();
    return null;
  }

  String? validateEmail(String? value) {
    if(value == null || value.isEmpty || value == '') {
      return 'Informe o e-mail';
    }

    _state.emailController.text = value;
    notifyListeners();
    return null;
  }

  String? validateNome(String? value) {
    if(value == null || value.isEmpty || value == '') {
      return 'Informe o nome';
    }

    _state.nomeController.text = value;
    notifyListeners();
    return null;
  }

}