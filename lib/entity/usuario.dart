import 'package:desafio_6_etapa/entity/tipo_usuario.dart';

class Usuario {
  String? id;
  String nome;
  String email;
  String? senha;
  TipoUsuario tipoUsuario = TipoUsuario.ATLETA;

  Usuario({this.id, required this.nome, required this.email, this.senha, this.tipoUsuario = TipoUsuario.ATLETA});

  Map<String, dynamic> toJson()  {
    return {
      'uuid': id,
      'nome': nome,
      'email': email,
      'tipoUsuario': tipoUsuario.toString().split('.').last
    };
  }
}