import 'package:desafio_6_etapa/finalizar_cadastro/finalizar_cadastro_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnderencoContent extends StatelessWidget {
  const EnderencoContent({super.key});

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
                    controller: controller.enderecoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Endereço',
                      hintText: 'Digite seu endereço',
                    ),
                  ),
                  TextFormField(
                    controller: controller.bairroController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Bairro',
                      hintText: 'Digite seu bairro',
                    ),
                  ),
                  TextFormField(
                    controller: controller.cepController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CEP',
                      hintText: 'Digite seu CEP',
                    ),
                  ),
                  TextFormField(
                    controller: controller.cidadeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cidade',
                      hintText: 'Digite sua cidade',
                    ),
                  ),
                  TextFormField(
                    controller: controller.enderecoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Estado',
                      hintText: 'Digite seu estado',
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
