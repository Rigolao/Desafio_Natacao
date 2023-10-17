import 'package:desafio_6_etapa/finalizar_cadastro/finalizar_cadastro_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DadosBasicosContent extends StatelessWidget {
  const DadosBasicosContent({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Provider.of<FinalizarCadastroController>(context, listen: false);

    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 16,
        children: [
          TextFormField(
            controller: controller.state.cpfController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CPF',
              hintText: 'Digite seu CPF',
            ),
          ),
          TextFormField(
            controller: controller.state.rgController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'RG',
              hintText: 'Digite seu RG',
            ),
          ),
          TextFormField(
            controller: controller.state.nomeMaeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome da Mãe',
              hintText: 'Digite o nome da mãe',
            ),
          ),
          TextFormField(
            controller: controller.state.nomePaiController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome do Pai',
              hintText: 'Digite o nome do pai',
            ),
          ),
          TextFormField(
            controller: controller.state.dataController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Data de Nascimento',
              hintText: 'Digite sua data de nascimento',
            ),
          ),
          TextFormField(
            controller: controller.state.naturalidadeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Naturalizade',
              hintText: 'Digite sua naturalidade',
            ),
          ),
          TextFormField(
            controller: controller.state.nacionalidadeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nacionalidade',
              hintText: 'Digite sua nacionalidade',
            ),
          ),
        ],
      ),
    );
  }
}
