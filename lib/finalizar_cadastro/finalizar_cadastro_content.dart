import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'finalizar_cadastro_controller.dart';

class FinalizarCadastroContent extends StatelessWidget {
  const FinalizarCadastroContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinalizarCadastroController(),
      builder: (context, child) {
        return Consumer<FinalizarCadastroController>(
          builder: (context, controller, child) {
            return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              appBar: AppBar(
                title: const Text('Finalizar Cadastro'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < controller.state.pages.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onTap: () {
                              controller.changePage(i);
                            },
                            child: CircleAvatar(
                              backgroundColor: controller.state.currentIndex == i
                                  ? Colors.blue
                                  : Colors.grey,
                              child: Text(
                                '${i + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    child: controller.state.pages[controller.state.currentIndex]
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (controller.state.currentIndex > 0)
                      FloatingActionButton(
                        onPressed: () {
                          controller.previousPage();
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    if (controller.state.currentIndex < controller.state.pages.length - 1)
                      FloatingActionButton(
                        onPressed: () {
                          controller.nextPage();
                        },
                        child: const Icon(Icons.arrow_forward),
                      ),
                    if (controller.state.currentIndex == controller.state.pages.length - 1)
                      FloatingActionButton(
                        onPressed: () {
                          controller.finalizarCadastro(context);
                        },
                        child: const Icon(Icons.check),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
