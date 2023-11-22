import 'package:desafio_6_etapa/entity/tipo_usuario.dart';

class UserData  {

  final String? name;
  final String? email;
  final TipoUsuario? tipoUsuario;

  UserData ({
    this.name,
    this.email,
    this.tipoUsuario,
  });
}