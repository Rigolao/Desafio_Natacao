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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_state.usuario == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Título do Alerta'),
              content: Text('Este é o conteúdo do alerta.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o alerta
                  },
                  child: Text('Fechar'),
                ),
              ],
            );
          },
        );
      }
      notifyListeners();
    });
  }
}
