import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import 'cadastrar_treino_controller.dart';

class CadastrarTreinoContent extends StatelessWidget {
  final Function fetchTreinos;
  const CadastrarTreinoContent({super.key, required this.fetchTreinos});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CadastrarTreinoController(),
      builder: (context, child) {
        return Consumer<CadastrarTreinoController>(
          builder: (context, controller, child) {
            controller.inicializar(context);

            if (controller.state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return WillPopScope(
              onWillPop: () async {
                final AppController appController =
                Provider.of<AppController>(context, listen: false);

                appController.state.treinoSelecionado = null;
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  title: const Text(
                    'Cadastrar Treino',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: controller.state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                  child: Form(
                    key: controller.state.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 16,
                        children: [
                          Column(
                            children: [
                              Text(
                                controller.state.horarioController.text
                                    .isEmpty
                                    ? 'Nenhum horário selecionado'
                                    : controller
                                    .state.horarioController.text,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.selectDateAndTime(context);
                                },
                                child: const Text(
                                  'Selecionar Data e Horário',
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            controller:
                            controller.state.descricaoController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Descrição',
                              hintText: 'Digite a descrição',
                            ),
                            maxLines: 6,
                          ),
                          FilledButton(
                            onPressed: () {
                              controller.cadastrarTreino(
                                  context, fetchTreinos);
                            },
                            child: Text(controller.state.treino != null
                                ? 'Atualizar Treino'
                                : 'Cadastrar Treino'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
