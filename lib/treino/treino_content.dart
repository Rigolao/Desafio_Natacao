import 'package:desafio_6_etapa/treino/treino_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../atletas_treino/atletas_treino_content.dart';

class TreinoContent extends StatefulWidget {
  const TreinoContent({super.key});

  @override
  State<TreinoContent> createState() => _TreinoContentState();
}

class _TreinoContentState extends State<TreinoContent> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TreinoController(),
        builder: (context, child) {
          return Consumer<TreinoController>(
              builder: (context, controller, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: controller.state.treinos > 0
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const ListTile(
                                leading: Icon(Icons.person),
                                title: Text('Treino X'),
                                subtitle: Text('Vallada'),
                                trailing: Icon(Icons.add),
                              ),
                              Container(
                                height: 200,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/nado.jpeg'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const ListTile(
                                title: Text('Horario: 12:00'),
                                subtitle: Text('Participantes: 33'),
                              ),
                              const Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor'),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: FilledButton(
                                      onPressed: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AtletaTreinoContent()),
                                            )
                                          },
                                      child: const Text('Participar')))
                            ],
                          )),
                    )
                  : const Center(
                      child: Text('Nenhum treino disponível'),
                    ),
            );
          });
        });
  }
}
