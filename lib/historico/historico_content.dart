import 'package:desafio_6_etapa/historico/historico_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricoContent extends StatelessWidget {
  const HistoricoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HistoricoController(),
        builder: (context, child) {
          return Consumer<HistoricoController>(
              builder: (context, controller, child) {
            controller.inicializar(context);

            if (controller.state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.state.treinos.isEmpty) {
              return const Center(child: Text('Nenhum treino encontrado'));
            }

            return ListView.builder(
                  itemCount: controller.state.treinos.length,
                  itemBuilder: (builder, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.area_chart),
                        title: Text(controller.state.treinos[index].horario),
                        onTap: () => controller.navegarParaResultadoTreino(context, controller.state.treinos[index]),
                      ),
                    );
                  });
          });
        });
  }
}
