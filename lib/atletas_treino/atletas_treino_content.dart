import 'package:desafio_6_etapa/shared/person_card.dart';
import 'package:desafio_6_etapa/theme/theme.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AtletaTreinoContent extends StatefulWidget {
  const AtletaTreinoContent({super.key});

  @override
  State<AtletaTreinoContent> createState() => _AtletaTreinoContentState();
}

class _AtletaTreinoContentState extends State<AtletaTreinoContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      Text('Segunda-Feira, 14 de outubro de 2023',
                          style: TextStyle(color: Colors.white)),
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
                      Text('7:00 - 8:00',
                          style: TextStyle(color: Colors.white)),
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
                      Text('Local: Piscina',
                          style: TextStyle(color: Colors.white)),
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
                      Text('2/20 Vagas disponíveis',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            )),
        Container(
          color: Colors.blue[100],
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: PersonCard(
              rating: false,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('LISTA DE PRESENÇA',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const PersonCard(
                rating: true,
              ),
              const SizedBox(
                height: 10,
              ),
              const PersonCard(
                rating: true,
              )
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: FilledButton(
              onPressed: () => {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.green))),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green)),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    SizedBox(
                      width: 10,
                    ),
                    Text('PARTICIPAR DO TREINO')
                  ],
                ),
              )),
        )
      ],
    );
  }
}
