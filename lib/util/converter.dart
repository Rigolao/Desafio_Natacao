import 'dart:io';

import 'package:desafio_6_etapa/entity/tipo_usuario.dart';

class ConversorEnum {
  static TipoUsuario converterStringParaEnum(String tipoUsuario) {
    switch (tipoUsuario.toUpperCase()) {
      case 'ADMINISTRADOR':
        return TipoUsuario.ADMINISTRADOR;
      case 'TREINADOR':
        return TipoUsuario.TREINADOR;
      case 'ATLETA':
        return TipoUsuario.ATLETA;
      default:
        throw ArgumentError('Tipo de usuário desconhecido: $tipoUsuario');
    }
  }

  static String converterEnumParaString(TipoUsuario tipoUsuario) {
    switch (tipoUsuario) {
      case TipoUsuario.ADMINISTRADOR:
        return 'ADMINISTRADOR';
      case TipoUsuario.TREINADOR:
        return 'TREINADOR';
      case TipoUsuario.ATLETA:
        return 'ATLETA';
      default:
        throw ArgumentError('Tipo de usuário desconhecido: $tipoUsuario');
    }
  }

  static Future<File?> converterImagePathParaFile(String? imagePath) async {
    if (imagePath == null) {
      return null;
    }
    return File(imagePath);
  }
}
