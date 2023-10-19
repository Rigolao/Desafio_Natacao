import 'package:flutter/material.dart';

import '../entity/tipo_usuario.dart';
import '../entity/usuario.dart';
import 'cadastrar_usuario_state.dart';

class CadastrarUsuarioController extends ChangeNotifier {
  final state = CadastrarUsuarioState();

  CadastrarUsuarioState get _state => state;

  void addUsuario(final List<Usuario> listaUsuarios) {
    final Usuario usuario = Usuario(
      nome: _state.nomeController.text,
      email: _state.emailController.text,
      senha: _state.senhaController.text,
      tipoUsuario: _state.usuario.tipoUsuario,
    );

    listaUsuarios.add(usuario);

    notifyListeners();
  }

  void editarUsuario(final List<Usuario> listaUsuarios, int index) {
    final Usuario usuario = Usuario(
      nome: _state.nomeController.text,
      email: _state.emailController.text,
      senha: _state.senhaController.text,
      tipoUsuario: _state.usuario.tipoUsuario,
    );

    listaUsuarios[index] = usuario;

    notifyListeners();
  }

  void atualizarTipoUsuario(bool isAdministrador) {
    _state.usuario.tipoUsuario = isAdministrador
        ? TipoUsuario.ADMINISTRADOR
        : TipoUsuario.TREINADOR;
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