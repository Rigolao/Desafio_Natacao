import 'package:desafio_6_etapa/entity/usuario.dart';

import '../entity/tipo_usuario.dart';
import '../entity/treino.dart';

class AppState {
  Usuario? usuario;
  Treino? treinoSelecionado;

  AppState({this.usuario, this.treinoSelecionado});
}