import 'package:desafio_6_etapa/login/login_state.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final _state = LoginState(
    GlobalKey<FormState>(),
    TextEditingController(),
    TextEditingController(),
    '',
    '',
    false,);

  LoginState get state => _state;

  void alterarVisibilidadeSenha() {
    _state.showPassword = !_state.showPassword;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if(value == null || value.isEmpty || value == '') {
      return 'Informe o e-mail';
    }

    _state.email = value;
    notifyListeners();
    return null;
  }

  String? validatePassword(String? value) {
    if(value == null || value.isEmpty || value == '') {
      return 'Informe a senha';
    }

    _state.password = value;
    notifyListeners();
    return null;
  }

  void logar(BuildContext context, GlobalKey<FormState> formKey) {
    if(formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

}