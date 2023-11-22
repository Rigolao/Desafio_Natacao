import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:desafio_6_etapa/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FlutterFireAuth {
  FlutterFireAuth(this._context);

  late final BuildContext _context;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _cloud = FirebaseFirestore.instance;

  void createUserWithEmailAndPassword(String email, String senha, TipoUsuario tipoUsuario){}
  Future<UserData?> signInWithEmailAndPassword(String email, String senha) async {
   try {
     final credencial = await _auth.signInWithEmailAndPassword(email: email, password: senha);

     final dadoUsuario = await _cloud.collection('tipoUsuario').doc(credencial.user!.uid).get();
     final tipoUsuario = dadoUsuario.get('tipoUsuario');

     return UserData(
       name: credencial.user?.displayName,
       email: credencial.user?.email,
       tipoUsuario: tipoUsuario
     );
   } on FirebaseAuthException catch (e) {
     ScaffoldMessenger.of(_context).showSnackBar(
       SnackBar(content: Text(e.message ?? 'Ocorreu um erro desconhecido')),
     );
   } catch (e) {
     ScaffoldMessenger.of(_context).showSnackBar(
       SnackBar(content: Text(e.toString())),
     );
   }

  }
  void getLoggedUser() {}
  void signOut() {}
}