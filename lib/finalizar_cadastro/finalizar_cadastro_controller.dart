import 'package:desafio_6_etapa/entity/atleta.dart';
import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:desafio_6_etapa/finalizar_cadastro/pages/dados_basicos.dart';
import 'package:desafio_6_etapa/finalizar_cadastro/pages/endereco_content.dart';
import 'package:desafio_6_etapa/finalizar_cadastro/pages/imagens_content.dart';
import 'package:desafio_6_etapa/finalizar_cadastro/pages/outros_content.dart';
import 'package:flutter/material.dart';

import 'finalizar_cadastro_state.dart';

class FinalizarCadastroController extends ChangeNotifier {

  final state = FinalizarCadastroState(
    const [
      DadosBasicosContent(),
      EnderencoContent(),
      OutrosContent(),
      ImagensContent(),
    ],
    0,
    Atleta(
      id: '0',
      nome: '',
      email: '',
      senha: '',
      sexo:  '',
      telefones: [],
      tipoUsuario: TipoUsuario.ATLETA,
      dataNascimento: DateTime.now(),
      naturalidade: '',
      nacionalidade: '',
      cpf: '',
      rg: '',
      endereco: '',
      bairro: '',
      cidade: '',
      estado: '',
      cep: '',
      nomePai: '',
      nomeMae: '',
      clubeOrigem: '',
      empresaTrabalha: '',
      cvm: '',
      alg: '',
      est: '',
      pvr: '',
    ),
  );

  void changePage(int index) {
    _state.currentIndex = index;
    notifyListeners();
  }

  void previousPage() {
    if (_state.currentIndex <= _state.pages.length - 1) {
      _state.currentIndex--;
      notifyListeners();
    }
  }

  void nextPage() {
    if (_state.currentIndex < _state.pages.length - 1) {
      _state.currentIndex++;
      notifyListeners();
    }
  }

  void finalizarCadastro(BuildContext context) {
    if (_state.currentIndex == _state.pages.length - 1) {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cadastro finalizado'),
          content: const Text('Cadastro finalizado com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
    }
  }

  // region Getters
  FinalizarCadastroState get _state => state;
  //endregion
}