import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:desafio_6_etapa/finalizar_cadastro/finalizar_cadastro_content.dart';
import 'package:flutter/material.dart';

import '../entity/usuario.dart';
import 'app_state.dart';

class AppController extends ChangeNotifier {
  final state = AppState();

  AppState get _state => state;

  void setUsuario(Usuario usuario) {
    _state.usuario = usuario;
    notifyListeners();
  }

  void isUsuarioCompleted(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_state.usuario?.tipoUsuario == TipoUsuario.ATLETA) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const FinalizarCadastroContent();
        }));
      }
      notifyListeners();
    });
  }
}
