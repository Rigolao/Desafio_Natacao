import 'package:desafio_6_etapa/atleta_historico/atleta_historico_controller.dart';
import 'package:desafio_6_etapa/entity/treino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AtletaHistoricoContent extends StatelessWidget {
  const AtletaHistoricoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AtletaHistoricoController(),
        builder: (context, child) {
          return Consumer<AtletaHistoricoController>(
              builder: (context, controller, child) {
            controller.inicializar(context);

            if (controller.state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  title: const Text(
                    'Resultado do Treino',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LineChart(
                      LineChartData(
                        minY: 0,
                        maxY: 600,
                        minX: 0,
                        maxX: controller.state.avaliacao!.intervalos.length.toDouble(),
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: const AxisTitles(
                            axisNameWidget: Text("Voltas"),
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          leftTitles: AxisTitles(
                            axisNameWidget: const Text("Minutos"),
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: getLeftTitles,
                            ),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: controller.state.avaliacao!.intervalos
                                .map((e) => FlSpot(
                                    e.volta.toDouble(),
                                    e.tempo.toDouble() / 1000))
                                .toList(),
                          )
                        ]),
                    )));
          });
        });
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    int minutes = value ~/ 60;
    int seconds = (value % 60).toInt();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        "$minutes:$seconds",
        softWrap: false,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
