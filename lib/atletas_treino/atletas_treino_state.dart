import '../entity/treino.dart';
import '../entity/usuario.dart';

class AtletasTreinoState {
  bool isLoading;
  String error;
  Treino? treino;
  List<Usuario> atletas;

  AtletasTreinoState({
    this.isLoading = true,
    this.error = '',
    this.atletas = const [],
  });
}