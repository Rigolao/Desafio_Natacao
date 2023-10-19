import 'package:desafio_6_etapa/entity/usuario.dart';
import 'package:desafio_6_etapa/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/tipo_usuario.dart';
import 'cadastrar_usuario_controller.dart';

class CadastrarUsuarioContent extends StatelessWidget {
  final Usuario? usuario;

  const CadastrarUsuarioContent({super.key, this.usuario});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CadastrarUsuarioController(),
        builder: (context, child) {
          return Consumer<CadastrarUsuarioController>(
              builder: (context, controller, child) {
            final homeController =
                Provider.of<HomeController>(context, listen: true);

            if (usuario != null) {
              controller.setUsuario(usuario!);
            }

            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  title: const Text('Cadastrar Usuário',
                      style: TextStyle(color: Colors.white)),
                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: controller.state.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 16,
                        children: [
                          TextFormField(
                            controller: controller.state.nomeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome',
                              hintText: 'Digite o nome',
                            ),
                          ),
                          TextFormField(
                            controller: controller.state.emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'E-mail',
                              hintText: 'Digite o email',
                            ),
                          ),
                          Center(
                            child: ToggleButtons(
                              borderWidth: 2,
                              borderRadius: BorderRadius.circular(10),
                              isSelected: [
                                controller.state.usuario.tipoUsuario ==
                                    TipoUsuario.ADMINISTRADOR,
                                controller.state.usuario.tipoUsuario ==
                                    TipoUsuario.TREINADOR,
                              ],
                              onPressed: (int index) {
                                controller.atualizarTipoUsuario(index == 0);
                              },
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Administrador'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Treinador'),
                                ),
                              ],
                            ),
                          ),
                          FilledButton(
                              onPressed: () {
                                if(controller.state.usuario.nome == '') {
                                  controller.addUsuario(homeController.state.usuarios);
                                } else {
                                  controller.editarUsuario(homeController.state.usuarios, homeController.state.usuarios.indexOf(usuario!));
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text(controller.state.usuario.nome == '' ? 'Cadastrar' : 'Atualizar'))
                        ],
                      ),
                    ),
                  ),
                ));
          });
        });
  }
}
