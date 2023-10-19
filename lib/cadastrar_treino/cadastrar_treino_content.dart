import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cadastrar_treino_controller.dart';

class CadastrarTreinoContent extends StatelessWidget {
  const CadastrarTreinoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CadastrarTreinoController(),
      builder: (context, child) {
        return Consumer<CadastrarTreinoController>(
          builder: (context, controller, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: const Text(
                  'Cadastrar Treino',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: controller.state.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 16,
                      children: [
                        Text(
                          controller.state.horarioController.text.isEmpty
                              ? 'Nenhum horário selecionado'
                              : controller.state.horarioController.text,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.selectDateAndTime(context);
                          },
                          child: Text(
                            'Selecionar Data e Horário',
                          ),
                        ),
                        // Use um TextField para o campo de descrição
                        TextField(
                          controller: controller.state.descricaoController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Descrição',
                            hintText: 'Digite a descrição',
                          ),
                          maxLines: 6,
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cadastrar'),
                        ),
                      ],
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
