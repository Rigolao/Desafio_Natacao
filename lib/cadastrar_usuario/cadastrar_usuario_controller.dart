import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import '../entity/tipo_usuario.dart';
import '../entity/usuario.dart';
import '../services/flutter_fire_auth.dart';
import 'cadastrar_usuario_state.dart';

class CadastrarUsuarioController extends ChangeNotifier {
  final state = CadastrarUsuarioState();

  CadastrarUsuarioState get _state => state;

  void addUsuario(final List<Usuario> listaUsuarios, BuildContext context) {
    state.isLoading = true;
    try {
      notifyListeners();

      final Usuario usuario = Usuario(
        nome: _state.nomeController.text,
        email: _state.emailController.text,
        tipoUsuario: _state.usuario.tipoUsuario,
      );

      debugPrint(usuario.tipoUsuario.toString().split('.').last);

      FlutterFireAuth.createUserWithEmailAndPassword(usuario, () {
        listaUsuarios.add(usuario);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário adicionado com sucesso!'),
          ),
        );

        Navigator.of(context).pop();

        state.isLoading = false;
        notifyListeners();});
    } catch (e) {
      print('Erro ao adicionar usuário: $e');

      state.isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao adicionar usuário: $e'),
        ),
      );
    }
  }


  Future<void> editarUsuario(BuildContext context, final Usuario usuario) async {
    state.isLoading = true;
    try {
      notifyListeners();

      final Usuario usuarioEditado = Usuario(
        nome: _state.nomeController.text,
        email: _state.emailController.text,
        senha: _state.senhaController.text,
        tipoUsuario: _state.usuario.tipoUsuario,
      );

      FlutterFireAuth.updateUser(usuarioEditado, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário editado com sucesso!'),
          ),
        );

        Navigator.of(context).pop();

        state.isLoading = false;
        notifyListeners();});
    } catch (e) {
      print('Erro ao editar usuário: $e');

      state.isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao editar usuário: $e'),
        ),
      );
    }
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