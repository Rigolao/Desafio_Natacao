import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/treino/treino_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TreinoContent extends StatelessWidget {
  const TreinoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TreinoController(),
        builder: (context, child) {
          return Consumer<TreinoController>(
              builder: (context, controller, child) {
            controller.inicializar(context);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: controller.state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.state.treinos.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.state.treinos.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.grey, width: 0.5),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.person),
                                        title: Text('Treino ${index + 1}'),
                                        subtitle: Text(controller
                                            .state.treinos[index].treinador),
                                        trailing: PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'editar') {
                                              controller.editarTreino(
                                                  context,
                                                  controller
                                                      .state.treinos[index]);
                                            } else if (value == 'excluir') {
                                              controller.excluirTreino(
                                                  context,
                                                  index,
                                                  controller
                                                      .state.treinos[index]);
                                            }
                                          },
                                          itemBuilder: (context) => [
                                            PopupMenuItem<String>(
                                              value: 'editar',
                                              child: Text('Editar'),
                                            ),
                                            PopupMenuItem<String>(
                                              value: 'excluir',
                                              child: Text('Excluir'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/nado.jpeg'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                            'Horário: ${controller.state.treinos[index].horario}'),
                                      ),
                                      Text(
                                          '${controller.state.treinos[index].descricao}'),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: ElevatedButton(
                                              onPressed: () => controller.participar(context, controller.state.treinos[index]),
                                              child: const Text('Participar')))
                                    ],
                                  )),
                            );
                          },
                        )
                      : const Center(
                          child: Text('Nenhum treino disponível'),
                        ),
            );
          });
        });
  }
}
