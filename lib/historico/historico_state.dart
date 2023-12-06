import '../entity/avaliacao.dart';
import '../entity/treino.dart';

class HistoricoState {
  bool isLoading;
  String error;
  List<Treino> treinos;

  HistoricoState({
    this.isLoading = true,
    this.error = '',
    this.treinos = const [],
  });
}