import 'package:flutter/material.dart';

import '../entity/tipo_usuario.dart';
import '../entity/usuario.dart';
import '../services/flutter_fire_auth.dart';
import 'cadastrar_usuario_state.dart';

class CadastrarUsuarioController extends ChangeNotifier {
  final state = CadastrarUsuarioState();

  CadastrarUsuarioState get _state => state;

  Future<void> addUsuario(final List<Usuario> listaUsuarios, BuildContext context) async {
    try {
      final Usuario usuario = Usuario(
        nome: _state.nomeController.text,
        email: _state.emailController.text,
        tipoUsuario: _state.usuario.tipoUsuario,
      );

      debugPrint(usuario.tipoUsuario.toString().split('.').last);

      // Use await para esperar a conclusão da função assíncrona
      FlutterFireAuth.createUserWithEmailAndPassword(usuario);

      listaUsuarios.add(usuario);

      notifyListeners();
    } catch (e) {
      print('Erro ao adicionar usuário: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao adicionar usuário: $e'),
          )
      );
    }
  }




  Future<void> editarUsuario(final List<Usuario> listaUsuarios, int index) async {
    final Usuario usuario = Usuario(
      nome: _state.nomeController.text,
      email: _state.emailController.text,
      senha: _state.senhaController.text,
      tipoUsuario: _state.usuario.tipoUsuario,
    );

    listaUsuarios[index] = usuario;

    notifyListeners();
  }

  void atualizarTipoUsuario(int index) {
    debugPrint(index.toString());
    switch (index) {
      case 0:
        _state.usuario.tipoUsuario = TipoUsuario.ADMINISTRADOR;
        break;
      case 1:
        _state.usuario.tipoUsuario = TipoUsuario.TREINADOR;
        break;
      case 2:
        _state.usuario.tipoUsuario = TipoUsuario.ATLETA;
        break;
      default:
        throw ArgumentError('Índice inválido: $index');
    }
    notifyListeners();
  }

  void setUsuario(Usuario usuario) {
    _state.usuario = usuario;
    _state.emailController.text = usuario.email;
    _state.nomeController.text = usuario.nome;

    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}