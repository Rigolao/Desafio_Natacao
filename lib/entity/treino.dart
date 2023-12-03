import 'package:uuid/uuid.dart';

class Treino {
  final String UUID;
  String descricao;
  String horario;
  final String treinadorUUID;
  final String treinador;

  Treino({
    String? UUID,
    required this.descricao,
    required this.horario,
    required this.treinadorUUID,
    required this.treinador,
  }) : UUID = UUID ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'UUID': UUID,
      'descricao': descricao,
      'horario': horario,
      'treinadorUUID': treinadorUUID,
      'treinador': treinador,
    };
  }

  Treino.fromJson(Map<String, dynamic> json)
      : UUID = json['UUID'] ?? '',
        descricao = json['descricao'] ?? '',
        horario = json['horario'] ?? '',
        treinadorUUID = json['treinadorUUID'] ?? '',
        treinador = json['treinador'] ?? '';
}