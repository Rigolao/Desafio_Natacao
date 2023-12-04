import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:desafio_6_etapa/entity/treino.dart';
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

  void setTreinoSelecionado(Treino? treino) {
    _state.treinoSelecionado = treino;
    notifyListeners();
  }

  void isUsuarioCompleted(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_state.usuario?.tipoUsuario == TipoUsuario.ATLETA) {
        bool primeiroAcesso = await verificarPrimeiroAcesso(_state.usuario?.id);

        if (primeiroAcesso) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const FinalizarCadastroContent();
          }));
        }
      }
      notifyListeners();
    });
  }

  Future<bool> verificarPrimeiroAcesso(String? uuid) async {
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    try {
      QuerySnapshot querySnapshot = await usuarios.where('uuid', isEqualTo: uuid).get();

      if (querySnapshot.docs.isNotEmpty) {
        bool primeiroAcesso = querySnapshot.docs.first['primeiroAcesso'];

        return primeiroAcesso;
      } else {
        return true;
      }
    } catch (e) {
      print('Erro ao realizar a consulta: $e');
      return true;
    }
  }


  void main() async {
    // Uso da função
    String uuid = 'seu_uuid_aqui';
    bool primeiroAcesso = await verificarPrimeiroAcesso(uuid);
    print('O usuário realizou o primeiro acesso? $primeiroAcesso');
  }

}
