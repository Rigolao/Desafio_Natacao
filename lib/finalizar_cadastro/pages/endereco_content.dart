import 'package:desafio_6_etapa/finalizar_cadastro/finalizar_cadastro_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnderencoContent extends StatelessWidget {
  const EnderencoContent({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Provider.of<FinalizarCadastroController>(context, listen: false);

    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 16,
        children: [
          TextFormField(
            controller: controller.state.enderecoController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Endereço',
              hintText: 'Digite seu endereço',
            ),
          ),
          TextFormField(
            controller: controller.state.bairroController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Bairro',
              hintText: 'Digite seu bairro',
            ),
          ),
          TextFormField(
            controller: controller.state.cepController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CEP',
              hintText: 'Digite seu CEP',
            ),
          ),
          TextFormField(
            controller: controller.state.cidadeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Cidade',
              hintText: 'Digite sua cidade',
            ),
          ),
          TextFormField(
            controller: controller.state.estadoController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Estado',
              hintText: 'Digite seu estado',
            ),
          ),
        ],
      ),
    );
  }
}
