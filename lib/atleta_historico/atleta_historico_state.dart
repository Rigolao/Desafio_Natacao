import '../entity/avaliacao.dart';
import '../entity/usuario.dart';

class AtletaHistoricoState {
  bool isLoading;
  String error;
  Avaliacao? avaliacao;

  AtletaHistoricoState({
    this.isLoading = true,
    this.error = ''
  });
}