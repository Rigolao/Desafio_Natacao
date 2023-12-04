import 'package:desafio_6_etapa/shared/person_card.dart';
import 'package:desafio_6_etapa/theme/theme.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/tipo_usuario.dart';
import '../entity/usuario.dart';
import 'atletas_treino_controller.dart';

class AtletaTreinoContent extends StatefulWidget {
  const AtletaTreinoContent({Key? key});

  @override
  State<AtletaTreinoContent> createState() => _AtletaTreinoContentState();
}

class _AtletaTreinoContentState extends State<AtletaTreinoContent> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AtletasTreinoController(),
        builder: (context, child) {
          return Consumer<AtletasTreinoController>(
              builder: (context, controller, child) {

                controller.inicializar(context);

                if (controller.state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title:
                    const Text('Treino', style: TextStyle(color: Colors.white)),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.date_range,
                                          color: Colors.white),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          controller.state.treino!.horario,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.blue[100],
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: PersonCard(
                                rating: false,
                                usuario: Usuario(
                                  id: controller.state.treino!.UUID,
                                  nome: controller.state.treino!.treinador,
                                  email: '',
                                  senha: '',
                                  tipoUsuario: TipoUsuario.TREINADOR,
                              )),
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
                                    Divider(color: Colors.grey)
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.state.atletas.length,
                                    itemBuilder: (itemBuilder, index) {
                                      return PersonCard(
                                          rating: true,
                                          callback: () => controller.inicializar(context),
                                          usuario: Usuario(
                                            id: controller.state.atletas[index].id,
                                            nome: controller.state.atletas[index].nome,
                                            email: controller.state.atletas[index].email,
                                            senha: '',
                                            tipoUsuario: controller.state.atletas[index].tipoUsuario,
                                          ));
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
          });
        });
  }
}
