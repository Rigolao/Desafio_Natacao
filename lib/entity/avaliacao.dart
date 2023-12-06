import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/entity/tempo_volta.dart';

class Avaliacao {
  String atletaUUID;
  String treinoUUID;
  Timestamp data;
  String ritmoInicial;
  String ritmoFinal;
  int tempoTotal;
  List<TempoVolta> intervalos;

  Avaliacao({
    required this.atletaUUID,
    required this.treinoUUID,
    required this.data,
    required this.ritmoInicial,
    required this.ritmoFinal,
    required this.tempoTotal,
    required this.intervalos,
  });

  Avaliacao.fromJson(Map<String, dynamic> json)
      : atletaUUID = json['atletaUUID'],
        treinoUUID = json['treinoUUID'],
        data = json['data'],
        ritmoInicial = json['ritmoInicial'],
        ritmoFinal = json['ritmoFinal'],
        tempoTotal = json['tempoTotal'],
        intervalos = (json['intervalos'] as List<dynamic>).map((item) => TempoVolta.fromJson(item)).toList();
}