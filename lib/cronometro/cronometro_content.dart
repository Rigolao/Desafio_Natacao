import 'dart:async';

import 'package:desafio_6_etapa/shared/person_card.dart';
import 'package:desafio_6_etapa/theme/theme.g.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CronometroContent extends StatefulWidget {
  const CronometroContent({super.key});

  @override
  State<CronometroContent> createState() => _CronometroContentState();
}

class _CronometroContentState extends State<CronometroContent> {
  int millisegundos = 0;
  Timer? timer;
  bool comecar = false;
  List<TempoVolta> intervalos = [];

  NumberFormat formatadorDuploZero = NumberFormat("00");
  NumberFormat formatadorTriploZero = NumberFormat("000");

  TempoVolta criarTempoVolta(List<TempoVolta> intervalos, int tempo) {
    if(intervalos.isEmpty) {
      return TempoVolta(tempo, tempo, intervalos.length + 1, isMelhorTempo(tempo), isPiorTempo(tempo));
    } else {
      return TempoVolta(tempo, tempo - intervalos.first.tempo, intervalos.length + 1, isMelhorTempo(tempo), isPiorTempo(tempo));
    }
  }

  String getTempoFormatado(int tempo) {
    int minutos = tempo ~/ 60 ~/ 1000;
    int segundos = (tempo - (minutos * 60 * 1000)) ~/ 1000;
    int milisegundos = tempo - (segundos * 1000) - (minutos * 60 * 1000);
    return "${formatadorDuploZero.format(minutos)}:${formatadorDuploZero.format(segundos)}:${formatadorTriploZero.format(milisegundos)}";
  }

  bool isMelhorTempo(int tempo) {
    bool melhorTempo = true;

    for(int i = 0; i < intervalos.length; i++) {
      if(tempo > intervalos[i].tempo) {
        melhorTempo = false;
      }
    }

    return melhorTempo;
  }

  bool isPiorTempo(int tempo) {
    bool piorTempo = true;

    for(int i = 0; i < intervalos.length; i++) {
      if(tempo < intervalos[i].tempo) {
        piorTempo = false;
      }
    }

    return piorTempo;
  }

  void parar() {
    timer!.cancel();
    setState(() {
      comecar = false;
    });
  }

  void reset() {
    timer!.cancel();
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
        millisegundos += 1;
      });
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const PersonCard(rating: false),
                Container(
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6E6FF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinhar à esquerda
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
                                fontWeight: FontWeight.bold, // Negrito para o rótulo "Volta"
                              ),
                            ),
                            Text(
                              "Tempo da Volta",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold, // Negrito para o rótulo "Tempo da Volta"
                              ),
                            ),
                            Text(
                              "Tempo",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold, // Negrito para o rótulo "Tempo da Volta"
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: intervalos.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    intervalos[index].volta.toString(),
                                    style: TextStyle(
                                      color: (){
                                        if(isMelhorTempo(intervalos[index].tempoVolta)) {
                                          return Colors.green;
                                        } else if(isPiorTempo(intervalos[index].tempoVolta)) {
                                          return Colors.red;
                                        } else {
                                          return Colors.black;
                                        }
                                      }(),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    getTempoFormatado(intervalos[index].tempoVolta),
                                    style: TextStyle(
                                      color: () {
                                        if(isMelhorTempo(intervalos[index].tempoVolta)) {
                                          return Colors.green;
                                        } else if(isPiorTempo(intervalos[index].tempoVolta)) {
                                          return Colors.red;
                                        } else {
                                          return Colors.black;
                                        }
                                      }(),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    getTempoFormatado(intervalos[index].tempo),
                                    style: TextStyle(
                                      color: () {
                                        if(intervalos[index].isMelhorVolta) {
                                          return Colors.green;
                                        } else if(intervalos[index].isPiorVolta) {
                                          return Colors.red;
                                        } else {
                                          return Colors.black;
                                        }
                                      }(),
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
                Stack(children: [
                  Container(
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0)),
                    ),
                  ),
                  Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(12.0),
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
                    IconButton(onPressed: () {
                      addIntervalos();
                    }, icon: const Icon(Icons.flag)),
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
              ]),
        )));
  }
}

class TempoVolta {
  int tempo;
  int tempoVolta;
  int volta;
  bool isMelhorVolta;
  bool isPiorVolta;

  TempoVolta(this.tempo, this.tempoVolta, this.volta, this.isMelhorVolta, this.isPiorVolta);
}
