import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import 'components/bottom_bar.dart';
import 'home_controller.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appController = Provider.of<AppController>(context, listen: false);

    appController.isUsuarioCompleted(context);

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
          },
        );
      },
    );
  }
}
