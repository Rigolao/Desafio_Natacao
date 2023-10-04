import 'package:desafio_6_etapa/shared/person_card.dart';
import 'package:desafio_6_etapa/theme/theme.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AtletaTreinoContent extends StatefulWidget {
  const AtletaTreinoContent({Key? key});

  @override
  State<AtletaTreinoContent> createState() => _AtletaTreinoContentState();
}

class _AtletaTreinoContentState extends State<AtletaTreinoContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Treino X', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: lightColorScheme.primary,
        ),
      body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      color: lightColorScheme.primary,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.date_range, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Segunda-Feira, 14 de outubro de 2023',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.timer, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '7:00 - 8:00',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.place, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Local: Piscina',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.person, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '2/20 Vagas disponíveis',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.blue[100],
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: PersonCard(
                          rating: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ATLETAS',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(
                                color: Colors.grey)
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 20,
                              itemBuilder: (itemBuilder, index) {
                                return const PersonCard(
                                  rating: true,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
