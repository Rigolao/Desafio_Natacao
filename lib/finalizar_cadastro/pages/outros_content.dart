import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../finalizar_cadastro_controller.dart';

class OutrosContent extends StatelessWidget {
  const OutrosContent({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Provider.of<FinalizarCadastroController>(context, listen: false);

    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 16,
        children: [
          TextFormField(
            controller: controller.state.clubeOrigemController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Clube de Origem',
              hintText: 'Digite seu clube de origem',
            ),
          ),
          TextFormField(
            controller: controller.state.empresaTrabalhaController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Empresa que Trabalha',
              hintText: 'Digite a empresa que trabalha',
            ),
          ),
          TextFormField(
            controller: controller.state.cvmController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Convênio Médico',
              hintText: 'Digite seu convénio médico',
            ),
          ),
          TextFormField(
            controller: controller.state.alergiaController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Alergias',
              hintText: 'Digite suas alergias',
            ),
          ),
          TextFormField(
            controller: controller.state.estController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Est',
              hintText: 'Digite seu est',
            ),
          ),
          TextFormField(
            controller: controller.state.pvrController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Pvr',
              hintText: 'Digite seu pvr',
            ),
          ),
        ],
      ),
    );
  }
}
