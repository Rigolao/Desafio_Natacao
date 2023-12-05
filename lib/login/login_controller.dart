import 'package:desafio_6_etapa/login/login_state.dart';
import 'package:desafio_6_etapa/services/flutter_fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';

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

  void _resetForm() {
    state.emailController.clear();
    state.senhaController.clear();
  }


  void logar(BuildContext context, GlobalKey<FormState> formKey) async {

    if (formKey.currentState!.validate()) {
      final AppController appController = Provider.of<AppController>(context, listen: false);

      final email = state.emailController.text;
      final senha = state.senhaController.text;

      final user = await FlutterFireAuth.signInWithEmailAndPassword(email, senha);

      print(user?.email);
      print(user?.nome);
      print(user?.tipoUsuario);
      print(user?.id);

      if (user != null) {
        appController.setUsuario(user);
        _resetForm();
        _navegacaoParaHome(context);
      }
    }
  }

  void _navegacaoParaHome (BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void enviarEmailDeRecuperacaoDeSenha(TextEditingController? email) {
    try {
      FlutterFireAuth.sendPasswordResetEmail(email.toString());
    } catch(e){
      print(e);
    }
  }
}
