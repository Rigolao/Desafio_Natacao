import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/app/app_controller.dart';
import 'package:desafio_6_etapa/entity/atleta.dart';
import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:desafio_6_etapa/finalizar_cadastro/pages/dados_basicos.dart';
import 'package:desafio_6_etapa/finalizar_cadastro/pages/endereco_content.dart';
import 'package:desafio_6_etapa/finalizar_cadastro/pages/imagens_content.dart';
import 'package:desafio_6_etapa/finalizar_cadastro/pages/outros_content.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      sexo: '',
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

  Future<String?> criarAtleta(
      BuildContext context, Map<String, dynamic> atletaDados) async {
    final AppController appController =
    Provider.of<AppController>(context, listen: false);

    final usuario = appController.state.usuario;

    final usuarios = FirebaseFirestore.instance.collection('usuarios');

    Map<String, String?> nomesArquivos = await saveAllDocs(atletaDados);

    await usuarios.doc(usuario!.id).set({
      ...atletaDados,
      'fotoRg': nomesArquivos['fotoRg'],
      'fotoCpf': nomesArquivos['fotoCpf'],
      'fotoAtleta': nomesArquivos['fotoAtleta'],
      'fotoComprovanteResidencia': nomesArquivos['fotoComprovanteResidencia'],
      'fotoAtestado': nomesArquivos['fotoAtestado'],
    }, SetOptions(merge: true));

    return usuario.id;
  }

  Future<Map<String, String?>> saveAllDocs(
      final Map<String, dynamic> atletaDados) async {
    Map<String, String?> nomesArquivos = {};

    if (atletaDados['fotoRg'] != null) {
      nomesArquivos['fotoRg'] = await _saveDoc(atletaDados['fotoRg']);
    }

    if (atletaDados['fotoCpf'] != null) {
      nomesArquivos['fotoCpf'] = await _saveDoc(atletaDados['fotoCpf']);
    }

    if (atletaDados['fotoAtleta'] != null) {
      nomesArquivos['fotoAtleta'] = await _saveDoc(atletaDados['fotoAtleta']);
    }

    if (atletaDados['fotoComprovanteResidencia'] != null) {
      nomesArquivos['fotoComprovanteResidencia'] =
      await _saveDoc(atletaDados['fotoComprovanteResidencia']);
    }

    if (atletaDados['fotoAtestado'] != null) {
      nomesArquivos['fotoAtestado'] = await _saveDoc(atletaDados['fotoAtestado']);
    }

    return nomesArquivos;
  }

  Future<String?> _saveDoc(dynamic value) async {
    Uint8List bytes;

    if (value is Uint8List) {
      bytes = value;
    } else if (value is String) {
      File file = File(value);
      bytes = await file.readAsBytes();
    } else {
      print('Tipo não suportado: ${value.runtimeType}');
      return null;
    }

    debugPrint("passei por aqui");

    String nomeArquivo = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference =
    FirebaseStorage.instance.ref().child('uploads/$nomeArquivo.jpg');
    await storageReference.putData(bytes);

    return nomeArquivo;
  }


  Atleta criarAtleta1(BuildContext context) {
    final AppController appController =
        Provider.of<AppController>(context, listen: false);

    final usuario = appController.state.usuario;

    debugPrint(usuario!.nome);

    return Atleta(
        id: usuario!.id,
        nome: usuario.nome,
        email: usuario.email,
        tipoUsuario: usuario.tipoUsuario,
        dataNascimento: DateTime.now(),
        naturalidade: state.naturalidadeController.text,
        nacionalidade: state.nacionalidadeController.text,
        rg: state.rgController.text,
        cpf: state.cpfController.text,
        sexo: '',
        endereco: state.enderecoController.text,
        bairro: state.bairroController.text,
        cep: state.cepController.text,
        cidade: state.cidadeController.text,
        estado: state.estadoController.text,
        nomeMae: state.nomeMaeController.text,
        nomePai: state.nomePaiController.text,
        clubeOrigem: state.clubeOrigemController.text,
        empresaTrabalha: state.empresaTrabalhaController.text,
        cvm: state.cvmController.text,
        alg: state.alergiaController.text,
        est: state.estadoController.text,
        pvr: state.pvrController.text,
        telefones: [],
        atestado: state.atestadoController,
        fotoRg: state.fotoRGController,
        fotoCpf: state.fotoCPFController,
        fotoCompRes: state.comprovanteResidenciaController,
        fotoAtleta: state.foto3x4Controller);
  }

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
      Atleta atleta = criarAtleta1(context);

      debugPrint('Nome da mae: ${atleta.nomeMae}');
      debugPrint(atleta.nomePai);
      debugPrint(atleta.nome);
      criarAtleta(context, atleta.toJson());

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Cadastro finalizado'),
              content: const Text('Cadastro finalizado com sucesso!'),
              actions: [
                TextButton(
                  onPressed: () {
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
