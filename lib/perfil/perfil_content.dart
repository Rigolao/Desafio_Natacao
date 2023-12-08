import 'dart:typed_data';

import 'package:desafio_6_etapa/perfil/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilContent extends StatelessWidget {
  const PerfilContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PerfilController(),
      builder: (context, child) {
        return Consumer<PerfilController>(
          builder: (context, controller, child) {

            controller.inicializar(context);

            if(controller.state.isLoading) return const Center(child: CircularProgressIndicator());

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.state.formKey,
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 16,
                    children: [
                      FutureBuilder<Uint8List?>(
                        future: controller.getFoto(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError || snapshot.data == null) {
                            return const CircleAvatar(
                              radius: 50.0,
                              child: Icon(Icons.person),
                            );
                          } else {
                            Image image = Image.memory(snapshot.data!);

                            return CircleAvatar(
                              radius: 50.0,
                              backgroundImage:image.image,
                            );
                          }
                        },
                      ),
                      TextFormField(
                        controller: controller.state.nomeController,
                        readOnly: !controller.state.isEditing,
                        validator: controller.validateNome,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome',
                        ),
                      ),
                      TextFormField(
                        controller: controller.state.emailController,
                        readOnly: true,
                        validator: controller.validateEmail,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      // Visibility(
                      //   visible: controller.state.isEditing,
                      //   child: TextFormField(
                      //     controller: controller.state.senhaController,
                      //     readOnly: !controller.state.isEditing,
                      //     obscureText: !controller.state.showPassword,
                      //     validator: controller.validatePassword,
                      //     decoration: InputDecoration(
                      //       border: const OutlineInputBorder(),
                      //       suffixIcon: IconButton(
                      //         icon: Icon(
                      //           controller.state.showPassword
                      //               ? Icons.visibility_off
                      //               : Icons.visibility,
                      //         ),
                      //         onPressed: () => controller.onShowPassword(),
                      //       ),
                      //       labelText: 'Senha',
                      //     ),
                      //   ),
                      // ),
                      Column(
                        children: [
                          FilledButton(onPressed: () {
                            if(controller.state.isEditing) {
                              controller.onEdit(context);
                            } else {
                              controller.invertIsEditing();
                            }
                          }, child: Text(controller.state.isEditing ? 'Salvar' : 'Editar')),
                          TextButton(onPressed: () {
                            if(controller.state.isEditing) {
                              controller.invertIsEditing();
                            } else {
                              controller.onLogout(context);
                            }
                          }, child: Text(controller.state.isEditing ? 'Cancelar' : 'Sair')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}


