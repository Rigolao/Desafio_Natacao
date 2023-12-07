import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
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

            controller.inicializar(context);

            return Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  title: const Text('Natação Unaerp',
                      style: TextStyle(color: Colors.white)),
                ),
                body: controller.state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : appController.state.usuario!.tipoUsuario ==
                            TipoUsuario.ADMINISTRADOR
                        ? Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.state.usuarios.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: const Icon(Icons.person),
                                      title: Text(controller
                                          .state.usuarios[index].nome),
                                      subtitle: Text(controller
                                          .state.usuarios[index].email),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () => controller.removerUsuario(context, controller
                                                .state.usuarios[index]),
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : controller.state.pages[controller.state.currentIndex],
                bottomNavigationBar: appController.state.usuario!.tipoUsuario ==
                        TipoUsuario.ADMINISTRADOR
                    ? null
                    : BottomBar(
                        controller.state.currentIndex,
                        controller.onTabTapped(
                            context,
                            controller.state.currentIndex,
                            appController.state.usuario!.tipoUsuario),
                        appController.state.usuario!),
                floatingActionButton:
                    appController.state.usuario!.tipoUsuario ==
                            TipoUsuario.ADMINISTRADOR
                        ? FloatingActionButton(
                            onPressed: () => controller.navegaCriarUsuario(context),
                            child: const Icon(Icons.add),
                          )
                        : null);
          },
        );
      },
    );
  }
}
