import 'package:desafio_6_etapa/finalizar_cadastro/finalizar_cadastro_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DadosBasicosContent extends StatelessWidget {
  const DadosBasicosContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinalizarCadastroController(),
      builder: (context, child) {
        return Consumer<FinalizarCadastroController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 16,
                children: [
                  TextFormField(
                    controller: controller.cpfController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CPF',
                      hintText: 'Digite seu CPF',
                    ),
                  ),
                  TextFormField(
                    controller: controller.rgController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'RG',
                      hintText: 'Digite seu RG',
                    ),
                  ),
                  TextFormField(
                    controller: controller.nomeMaeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome da Mãe',
                      hintText: 'Digite o nome da mãe',
                    ),
                  ),
                  TextFormField(
                    controller: controller.nomePaiController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome do Pai',
                      hintText: 'Digite o nome do pai',
                    ),
                  ),
                  TextFormField(
                    controller: controller.dataController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data de Nascimento',
                      hintText: 'Digite sua data de nascimento',
                    ),
                  ),
                  TextFormField(
                    controller: controller.naturalidadeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Naturalizade',
                      hintText: 'Digite sua naturalidade',
                    ),
                  ),
                  TextFormField(
                    controller: controller.nacionalidadeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nacionalidade',
                      hintText: 'Digite sua nacionalidade',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
