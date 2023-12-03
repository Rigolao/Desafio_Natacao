import 'package:desafio_6_etapa/entity/treino.dart';

class TreinoState {
  bool isLoading;
  List<Treino> treinos = List<Treino>.empty();
  String mensagem = '';

  TreinoState({this.isLoading = true});
}
