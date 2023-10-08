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
      id: 0,
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

  // region Controllers
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _naturalidadeController = TextEditingController();
  final TextEditingController _nacionalidadeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _nomePaiController = TextEditingController();
  final TextEditingController _nomeMaeController = TextEditingController();
  final TextEditingController _clubeOrigemController = TextEditingController();
  final TextEditingController _empresaTrabalhaController = TextEditingController();
  final TextEditingController _cvmController = TextEditingController();
  final TextEditingController _alergiaController = TextEditingController();
  final TextEditingController _estController = TextEditingController();
  final TextEditingController _pvrController = TextEditingController();
  String? atestadoController = '';
  // endregion

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

  TextEditingController get dataController => _dataController;

  TextEditingController get naturalidadeController => _naturalidadeController;

  TextEditingController get nacionalidadeController => _nacionalidadeController;

  TextEditingController get cpfController => _cpfController;

  TextEditingController get rgController => _rgController;

  TextEditingController get enderecoController => _enderecoController;

  TextEditingController get bairroController => _bairroController;

  TextEditingController get cidadeController => _cidadeController;

  TextEditingController get estadoController => _estadoController;

  TextEditingController get cepController => _cepController;

  TextEditingController get nomePaiController => _nomePaiController;

  TextEditingController get nomeMaeController => _nomeMaeController;

  TextEditingController get clubeOrigemController => _clubeOrigemController;

  TextEditingController get empresaTrabalhaController =>
      _empresaTrabalhaController;

  TextEditingController get cvmController => _cvmController;

  TextEditingController get alergiaController => _alergiaController;

  TextEditingController get estController => _estController;

  TextEditingController get pvrController => _pvrController;
  // endregion
}