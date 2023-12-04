import 'dart:async';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/app/app_controller.dart';
import 'package:desafio_6_etapa/entity/atleta.dart';
import 'package:desafio_6_etapa/entity/usuario.dart';
import 'package:desafio_6_etapa/shared/batimento_dialog.dart';
import 'package:desafio_6_etapa/shared/person_card.dart';
import 'package:desafio_6_etapa/theme/theme.g.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../entity/tempo_volta.dart';

class CronometroContent extends StatefulWidget {
  Usuario? atleta;
  String ritmoInicial;

  CronometroContent({super.key, required this.ritmoInicial, this.atleta}) {
    atleta ??= Usuario(nome: "Vazio", email: "vazio", senha: "vazio");
  }

  @override
  State<CronometroContent> createState() => _CronometroContentState();
}

class _CronometroContentState extends State<CronometroContent> {
  int millisegundos = 0;
  Timer? timer;
  bool comecar = false;
  List<TempoVolta> intervalos = [];

  final TextEditingController _controller = TextEditingController();

  TempoVolta? melhorVolta;
  TempoVolta? piorVolta;

  NumberFormat formatadorDuploZero = NumberFormat("00");
  NumberFormat formatadorTriploZero = NumberFormat("000");

  int indexPiorVolta = 0;
  int indexMelhorVolta = 0;

  final _db = FirebaseFirestore.instance;

  TempoVolta criarTempoVolta(List<TempoVolta> intervalos, int tempo) {
    if (intervalos.isEmpty) {
      return TempoVolta(
          tempo: tempo,
          tempoVolta: tempo,
          volta: intervalos.length + 1,
          isMelhorVolta: isMelhorTempo(tempo),
          isPiorVolta: isPiorTempo(tempo));
    } else {
      return TempoVolta(
          tempo: tempo,
          tempoVolta: tempo - intervalos.first.tempo,
          volta: intervalos.length + 1,
          isMelhorVolta: isMelhorTempo(tempo - intervalos.first.tempo),
          isPiorVolta: isPiorTempo(tempo - intervalos.first.tempo));
    }
  }

  String getTempoFormatado(int tempo) {
    int minutos = tempo ~/ 60 ~/ 1000;
    int segundos = (tempo - (minutos * 60 * 1000)) ~/ 1000;
    int milisegundos = tempo - (segundos * 1000) - (minutos * 60 * 1000);
    return "${formatadorDuploZero.format(minutos)}:${formatadorDuploZero.format(segundos)}:${formatadorTriploZero.format(milisegundos)}";
  }

  bool isMelhorTempo(int tempo) {
    if (intervalos.isEmpty) {
      return true;
    }

    var melhorVolta =
        intervalos.firstWhere((intervalo) => intervalo.isMelhorVolta);

    if (melhorVolta.tempoVolta > tempo) {
      melhorVolta.isMelhorVolta = false;
      return true;
    } else {
      return false;
    }
  }

  bool isPiorTempo(int tempo) {
    if (intervalos.isEmpty) {
      return true;
    }

    TempoVolta? piorVolta =
        intervalos.firstWhere((intervalo) => intervalo.isPiorVolta);

    if (piorVolta.tempoVolta < tempo) {
      piorVolta.isPiorVolta = false;
      return true;
    } else {
      return false;
    }
  }

  void parar() {
    if (timer != null) timer!.cancel();
    setState(() {
      comecar = false;
    });
  }

  void reset() {
    if (timer != null) timer!.cancel();

    setState(() {
      millisegundos = 0;

      comecar = false;

      intervalos = [];
    });
  }

  void addIntervalos() {
    setState(() {
      intervalos.insert(0, criarTempoVolta(intervalos, millisegundos));
    });
  }

  void start() {
    comecar = true;

    timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      setState(() {
        millisegundos = timer.tick;
      });
    });
  }

  Future<void> salvaFirebase() async {
    final AppController appController =
        Provider.of<AppController>(context, listen: false);

    await _db.collection('avaliacoes').doc().set({
      'treinoUUID': appController.state.treinoSelecionado!.UUID,
      'atletaUUID': widget.atleta!.id,
      'ritmoInicial': widget.ritmoInicial,
      'ritmoFinal': _controller.text,
      'intervalos': intervalos.map((e) => e.toJson()).toList(),
      'tempoTotal': millisegundos,
      'data': DateTime.now()
    }).then(
        (value) => Navigator.popUntil(context, ModalRoute.withName('/treino')));
  }

  void salvarAvaliacao(BuildContext context) async {
    parar();
    batimentoCard(context, salvaFirebase, _controller);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final Map<String, dynamic>? arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        setState(() {
          widget.atleta = arguments['atleta'];
          widget.ritmoInicial = arguments['ritmoInicial'] ?? '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Avaliação',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: lightColorScheme.primary,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PersonCard(rating: false, usuario: widget.atleta!),
                Container(
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6E6FF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Volta",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tempo da Volta",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tempo",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: intervalos.length,
                          itemBuilder: (context, index) {
                            final color = () {
                              if (intervalos[index].isMelhorVolta &&
                                  intervalos[index].isPiorVolta) {
                                return Colors.green;
                              } else if (intervalos[index].isMelhorVolta) {
                                return Colors.green;
                              } else if (intervalos[index].isPiorVolta) {
                                return Colors.red;
                              } else {
                                return Colors.black;
                              }
                            }();
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    intervalos[index].volta.toString(),
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    getTempoFormatado(
                                        intervalos[index].tempoVolta),
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    getTempoFormatado(intervalos[index].tempo),
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Column(children: [
                  Container(
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: () {
                        if (comecar)
                          return Colors.green;
                        else
                          return Colors.red;
                      }(),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0)),
                    ),
                  ),
                  Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0)),
                    ),
                    child: Center(
                        child: Text(
                      getTempoFormatado(millisegundos),
                      style: const TextStyle(
                        fontSize: 64.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    )),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: RawMaterialButton(
                            onPressed: () {
                              (!comecar) ? start() : parar();
                            },
                            shape: const StadiumBorder(
                              side: BorderSide(color: Colors.blue),
                            ),
                            child: Text((!comecar) ? "Começar" : "Parar",
                                style: const TextStyle(color: Colors.black)))),
                    const SizedBox(width: 8.0),
                    IconButton(
                        onPressed: () {
                          addIntervalos();
                        },
                        icon: const Icon(Icons.flag)),
                    const SizedBox(width: 8.0),
                    Expanded(
                        child: RawMaterialButton(
                            onPressed: () {
                              reset();
                            },
                            fillColor: Colors.blue,
                            shape: const StadiumBorder(
                              side: BorderSide(color: Colors.blue),
                            ),
                            child: const Text("Reset",
                                style: TextStyle(color: Colors.black))))
                  ],
                ),
                FilledButton(
                    onPressed: () => salvarAvaliacao(context),
                    child: const Text('Finalizar')),
              ]),
        )));
  }
}
