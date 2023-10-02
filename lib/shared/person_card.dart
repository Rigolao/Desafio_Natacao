  import 'package:desafio_6_etapa/animation/HeartbeatIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

  class PersonCard extends StatelessWidget {
    final bool rating;
    const PersonCard({required this.rating, super.key});

    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Matheus Rigolão'),
            subtitle: const Text('Treinador', style: TextStyle(color: Colors.grey)),
            trailing: rating == true ? FilledButton(onPressed: () => { _showModal(context)
            }, child: Text('AVALIAR')) : null
          ),
        ),
      );
    }
  }

  void _showModal(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: width,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('FREQUÊNCIA CARDÍACA', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text('Antes de continuar, por favor, insira sua frequência cardíaca inicial (batimentos por minuto).',
                  style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),),
                ),
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
                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: TextField(
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24.0, color: Colors.black),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none, // Remove o sublinhado
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeartbeatIcon(),
                      Text('BPM', style: TextStyle(letterSpacing: 2.0, color: Colors.red, fontWeight: FontWeight.bold),),
                    ],
                  )],
                )
              ],
            ),
          ),
        );
      },
    );
    future.then((void value) => _closeModal(value));
  }
  void _closeModal(void value) {
    print('modal closed');
  }
