import 'package:desafio_6_etapa/treino/treino_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            controller.inicializar(context);

            if (controller.state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: controller.state.treinos > 0
                  ? Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.grey, width: 0.5),
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
                                      onPressed: () =>
                                          controller.participar(context),
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
