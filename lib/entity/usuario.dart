import 'package:desafio_6_etapa/entity/tipo_usuario.dart';

class Usuario {
  int? id;
  String nome;
  String email;
  String senha;
  TipoUsuario tipoUsuario = TipoUsuario.ATLETA;

  Usuario({this.id, required this.nome, required this.email, required this.senha, this.tipoUsuario = TipoUsuario.ATLETA});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipoAtleta': tipoUsuario,
    };
  }
}