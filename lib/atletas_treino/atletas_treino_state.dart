import '../entity/treino.dart';

class AtletasTreinoState {
  bool isLoading;
  String error;
  Treino? treino;

  AtletasTreinoState({
    this.isLoading = true,
    this.error = '',
  });
}