import 'package:desafio_6_etapa/login/login_state.dart';
import 'package:desafio_6_etapa/shared/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import '../entity/tipo_usuario.dart';
import '../entity/usuario.dart';

class LoginController extends ChangeNotifier {
  final _state = LoginState(GlobalKey<FormState>(), TextEditingController(),
      TextEditingController(), '', '', false, '');

  LoginState get state => _state;

  void alterarVisibilidadeSenha() {
    _state.showPassword = !_state.showPassword;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty || value == '') {
      return 'Informe o e-mail';
    }

    _state.email = value;
    notifyListeners();
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty || value == '') {
      return 'Informe a senha';
    }

    _state.password = value;
    notifyListeners();
    return null;
  }

  void logar(BuildContext context, GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      final AppController appController =
          Provider.of<AppController>(context, listen: false);
      Usuario usuario;

      if (state.emailController.text != 'matheus@email.com' &&
          state.emailController.text != 'joao@email.com' &&
          state.emailController.text != 'diego@email.com') {
        _state.error = 'Usuário não encontrado';

        showAlertDialog(context, _state.error, () {
          clearError();
        });

        notifyListeners();
        return;
      }

      if (state.emailController.text == 'matheus@email.com') {
        usuario = Usuario(
          nome: 'Matheus',
          email: state.email,
          senha: state.password,
          tipoUsuario: TipoUsuario.ADMINISTRADOR,
        );
      } else if (state.emailController.text == 'joao@email.com') {
        usuario = Usuario(
          nome: 'João',
          email: state.email,
          senha: state.password,
          tipoUsuario: TipoUsuario.TREINADOR,
        );
      } else {
        usuario = Usuario(
          nome: 'Diego',
          email: state.email,
          senha: state.password,
          tipoUsuario: TipoUsuario.ATLETA,
        );
      }

      appController.setUsuario(usuario);

      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void clearError() {
    _state.error = '';
    notifyListeners();
  }
}
