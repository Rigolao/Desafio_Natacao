import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:desafio_6_etapa/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../entity/usuario.dart';

class FlutterFireAuth {
  FlutterFireAuth(this._context);

  late final BuildContext _context;

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _cloud = FirebaseFirestore.instance;
  static const COLECAO_USUARIOS = 'usuarios';

  static Future<void> sendPasswordResetEmail(String userEmail) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail);
      debugPrint(
          'E-mail de redefinição de senha enviado com sucesso para $userEmail.');
    } catch (e) {
      debugPrint('Erro ao enviar e-mail de redefinição de senha: $e');
    }
  }

  static void createUserWithEmailAndPassword(
      Usuario usuario, Function callback) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: usuario.email, password: randomAlphaNumeric(8));

      usuario.id = userCredential.user!.uid;

      await _cloud
          .collection(COLECAO_USUARIOS)
          .doc(userCredential.user!.uid)
          .set(usuario.toJson())
          .then((value) {
        sendPasswordResetEmail(usuario.email);
        debugPrint('deu certo');
        callback();
      });
    } catch (e) {
      if (usuario.id != null) {
        debugPrint('Rollback iniciando...');
        await _auth.currentUser?.delete();
        debugPrint('Rollback concluido');
      }
    }
  }

  static Future<Usuario?> signInWithEmailAndPassword(
      String email, String senha) async {
    try {
      final credencial = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      final String userUid = credencial.user!.uid;

      final dadoUsuario =
          await _cloud.collection('usuarios').doc(userUid).get();

      if (dadoUsuario.exists) {
        final Map<String, dynamic>? dados = dadoUsuario.data();

        if (dados != null) {
          return Usuario(
              nome: dados['nome'],
              email: dados['email'],
              tipoUsuario: getTipoUsuario(dados['tipoUsuario']),
              id: dados['uuid']);
        } else {
          print('Os dados do documento são nulos.');
          return null;
        }
      } else {
        print('O documento não foi encontrado no Firestore.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static TipoUsuario getTipoUsuario(String tipoUsuario) {
    switch (tipoUsuario) {
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

  static void updateUser(Usuario usuario, Function function) async {
    try {
      _auth.currentUser?.updateEmail(usuario.email).then((value) {
        _cloud
            .collection(COLECAO_USUARIOS)
            .doc(usuario.id)
            .update(usuario.toJson())
            .then((_) {
          function();
        });
      });
    } catch (e) {
      debugPrint('Erro ao atualizar usuário: $e');
    }
  }

  static void editingUser(Usuario usuario) async {
    try{
      await _cloud.collection('usuarios').doc(usuario.id).update({
        'nome': usuario.nome,
      });
    }catch(e){
      print(e);
    };
  }

  static void deleteUser(Usuario usuario, Function function) async {
    try {
      _auth.currentUser?.delete().then((value) {
        _cloud.collection(COLECAO_USUARIOS).doc(usuario.id).delete().then((_) {
          function();
        });
      });
    } catch (e) {
      debugPrint('Erro ao remover usuário: $e');
    }
  }
}
