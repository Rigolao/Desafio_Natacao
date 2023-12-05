import 'dart:async';
import 'dart:js_interop_unsafe';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_6_etapa/cadastrar_usuario/cadastrar_usuario_content.dart';
import 'package:desafio_6_etapa/perfil/perfil_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_controller.dart';
import '../entity/tipo_usuario.dart';
import '../entity/usuario.dart';
import '../services/flutter_fire_auth.dart';
import '../treino/treino_content.dart';
import 'components/bottom_sheet_button.dart';
import 'home_state.dart';

class HomeController extends ChangeNotifier {
  final state = HomeState('Treinos', 0, [
    const TreinoContent(),
    Page2(),
    const PerfilContent()
  ], []);

  HomeState get _state => state;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void inicializar(BuildContext context) {
    if (_state.isLoading) {
      final AppController appController = Provider.of<AppController>(context, listen: false);

      _firebaseFirestore.collection('usuarios').get().then((value) {
        _state.usuarios = List.empty();

        List<Usuario> usuarios = value.docs
            .map((e) => Usuario.fromMap(e.data() as Map<String, dynamic>, e.id))
            .toList();

        List<Usuario> usuariosValidos = [];

        for (var element in usuarios) {
          if (element.id != appController.state.usuario?.id) {
            usuariosValidos.add(element);
          }
        }

        _state.usuarios = usuariosValidos;

        _state.isLoading = false;
        notifyListeners();

        print('Usuários carregados com sucesso!');
      }).catchError((error) {
        _state.isLoading = false;
        _state.mensagem = 'Erro ao buscar usuários: $error';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_state.mensagem),
            duration: const Duration(seconds: 2),
          ),
        );

        _state.isLoading = false;
        notifyListeners();
      });
    }
  }

  void removerUsuario(BuildContext _context, Usuario usuario) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Tem certeza de que deseja remover este usuário?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _removerUsuario(_context, usuario);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  void _removerUsuario(BuildContext context, Usuario usuario) {
    FlutterFireAuth.deleteUser(usuario, () {
      _state.isLoading = true;
      notifyListeners();

      _firebaseFirestore.collection('usuarios').doc(usuario.id).delete().then((value) {
        _state.usuarios.remove(usuario);

        _state.isLoading = false;
        notifyListeners();

        print('Usuário removido com sucesso!');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário removido com sucesso!'),
            duration: Duration(seconds: 2),
          ),
        );
      }).catchError((error) {
        _state.isLoading = false;
        _state.mensagem = 'Erro ao remover usuário: $error';

        print(_state.mensagem);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao remover usuário!'),
            duration: Duration(seconds: 2),
          ),
        );

        notifyListeners();
      });
    });
  }

  void navegaCriarUsuario(BuildContext context, {Usuario? usuario}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CadastrarUsuarioContent(usuario: usuario);
    })).then((_) {
      state.isLoading = true;
      notifyListeners();
      inicializar(context);
    });
  }

  Function(int) onTabTapped(
      BuildContext context, int index, TipoUsuario tipoUsuario) {
    if (index == 1 && tipoUsuario == TipoUsuario.TREINADOR) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          const Text('Criar',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          const Spacer(),
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BottomSheetButton(
                                icone: Icons.sports,
                                texto: 'Cadastrar Treinador',
                                onPressed: () => {
                                  Navigator.of(context).pushNamed('/cadastrar-usuario')
                                }),
                            BottomSheetButton(
                                icone: Icons.create,
                                texto: 'Cadastrar Treino',
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).pushNamed('/cadastrar-treino');
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          });
    } else {
      _state.currentIndex = index;
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _state.currentIndex = index;
      notifyListeners();
    });
    return (index) => onTabTapped(context, index, tipoUsuario);
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Histórico de treinos'),
    );
  }
}

