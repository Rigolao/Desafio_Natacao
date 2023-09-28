import 'package:desafio_6_etapa/atletas_treino/atletas_treino_content.dart';
import 'package:desafio_6_etapa/entity/usuario.dart';
import 'package:desafio_6_etapa/treino/treino_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/tipo_usuario.dart';
import 'components/bottom_bar.dart';
import 'components/bottom_sheet_button.dart';
import 'home_controller.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeController(),
        builder: (context, child) {
          return Consumer<HomeController>(
              builder: (context, controller, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: const Text('Natação Unaerp',
                    style: TextStyle(color: Colors.white)),
              ),
              body: controller.state.pages[controller.state.currentIndex],
              bottomNavigationBar: BottomBar(
                  controller.state.currentIndex,
                  controller.onTabTapped(
                      context, controller.state.currentIndex),
                  controller.state.usuario),
            );
          });
        });
  }
}
