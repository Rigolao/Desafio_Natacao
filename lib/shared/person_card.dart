import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../animation/HeartbeatIcon.dart';

  class PersonCard extends StatelessWidget {
    final bool rating;

    const PersonCard({required this.rating, super.key});

    @override
    Widget build(BuildContext context) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              dense: true,
              leading: const Icon(Icons.person),
              title: const Text('Matheus Rigolão'),
              subtitle: const Text(
                  'Treinador', style: TextStyle(color: Colors.grey)),
              trailing: rating == true ?
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: IconButton(
                    autofocus: true,
                    focusColor: Colors.blue[200],
                    onPressed: () {
                      _showModal(context);
                    },
                    icon: const Icon(Icons.timer_outlined)),
              ) : null
          ),
        ),
      );
    }

    void _showModal(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'FREQUÊNCIA CARDÍACA',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Antes de continuar, por favor, insira sua frequência cardíaca inicial (batimentos por minuto).',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: TextField(
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 24.0,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeartbeatIcon(),
                          const Text(
                            'BPM',
                            style: TextStyle(
                              letterSpacing: 2.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/cronometro');
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

  }