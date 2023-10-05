import 'dart:async';

import 'package:desafio_6_etapa/shared/person_card.dart';
import 'package:desafio_6_etapa/theme/theme.g.dart';
import 'package:flutter/material.dart';

class CronometroContent extends StatefulWidget {
  const CronometroContent({super.key});

  @override
  State<CronometroContent> createState() => _CronometroContentState();
}

class _CronometroContentState extends State<CronometroContent> {
  int segundos = 0, minutos = 0, horas = 0;
  String digitoSegundos = "00", digitoMinutos = "00", digitoHoras = "00";
  Timer? timer;
  bool comecar = false;
  List intervalos = [];

  //controles

  void parar() {
    timer!.cancel();
    setState(() {
      comecar = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      segundos = 0;
      minutos = 0;
      horas = 0;

      digitoSegundos = "00";
      digitoMinutos = "00";
      digitoHoras = "00";

      comecar = false;

      intervalos = [];
    });
  }

  void addIntervalos() {
    setState(() {
      intervalos.add("$digitoHoras : $digitoMinutos : $digitoSegundos");
    });
  }

  void start() {
    comecar = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        segundos++;
        if (segundos == 60) {
          segundos = 0;
          minutos++;
        }
        if (minutos == 60) {
          minutos = 0;
          horas++;
        }

        if (segundos < 10) {
          digitoSegundos = "0$segundos";
        } else {
          digitoSegundos = "$segundos";
        }

        if (minutos < 10) {
          digitoMinutos = "0$minutos";
        } else {
          digitoMinutos = "$minutos";
        }

        if (horas < 10) {
          digitoHoras = "0$horas";
        } else {
          digitoHoras = "$horas";
        }
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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
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
                                    "Volta nº${index + 1}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    "${intervalos[index]}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    "${intervalos[index]}",
                                    style: TextStyle(
                                      color: Colors.black,
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
                      borderRadius: BorderRadius.only(
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
                      "$digitoHoras : $digitoMinutos : $digitoSegundos",
                      style: TextStyle(
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
                                style: TextStyle(color: Colors.black)))),
                    SizedBox(width: 8.0),
                    IconButton(onPressed: () {
                      addIntervalos();
                    }, icon: Icon(Icons.flag)),
                    SizedBox(width: 8.0),
                    Expanded(
                        child: RawMaterialButton(
                            onPressed: () {
                              reset();
                            },
                            fillColor: Colors.blue,
                            shape: const StadiumBorder(
                              side: BorderSide(color: Colors.blue),
                            ),
                            child: Text("Parar",
                                style: TextStyle(color: Colors.black))))
                  ],
                ),
              ]),
        )));
  }
}
