import 'package:desafio_6_etapa/finalizar_cadastro/finalizar_cadastro_controller.dart';
import 'package:desafio_6_etapa/shared/photo_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagensContent extends StatelessWidget {
  const ImagensContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinalizarCadastroController(),
      builder: (context, child) {
        return Consumer<FinalizarCadastroController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              child: Wrap(
                children: [
                  PhotoPicker(title: "Atestado médico", changeImage: (value) {
                    controller.atestadoController = value;
                  }),
                  PhotoPicker(title: "RG", changeImage: (value) {
                    controller.atestadoController = value;
                  }),
                  PhotoPicker(title: "CPF", changeImage: (value) {
                    controller.atestadoController = value;
                  }),
                  PhotoPicker(title: "Comprovante de residência", changeImage: (value) {
                    controller.atestadoController = value;
                  }),
                  PhotoPicker(title: "Foto 3x4", changeImage: (value) {
                    controller.atestadoController = value;
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
