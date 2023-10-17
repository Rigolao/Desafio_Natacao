import 'dart:async';

import 'package:desafio_6_etapa/cadastrar_usuario/cadastrar_usuario_content.dart';
import 'package:flutter/material.dart';

import '../atletas_treino/atletas_treino_content.dart';
import '../entity/tipo_usuario.dart';
import '../entity/usuario.dart';
import '../treino/treino_content.dart';
import 'components/bottom_sheet_button.dart';
import 'home_state.dart';

class HomeController extends ChangeNotifier {
  final state = HomeState('Treinos', 0, [
    const TreinoContent(),
    Page2(),
    Page3(),
  ], []);

  HomeState get _state => state;

  void inicializar(TipoUsuario tipoUsuario) {
    if (_state.isLoading) {
      Timer(const Duration(seconds: 2), () {
        if (tipoUsuario == TipoUsuario.ADMINISTRADOR) {
          state.usuarios.addAll([
            Usuario(
              nome: 'Matheus',
              email: 'matheus@email.com',
              senha: '123456',
              tipoUsuario: TipoUsuario.TREINADOR,
            ),
            Usuario(
              nome: 'João',
              email: 'jao@email.com',
              senha: '123456',
              tipoUsuario: TipoUsuario.ADMINISTRADOR,
            ),
            Usuario(
              nome: 'Diego',
              email: 'diego@email.com',
              senha: '123456',
              tipoUsuario: TipoUsuario.ADMINISTRADOR,
            ),
          ]);
        }

        _state.isLoading = false;
        notifyListeners();
      });
    }
  }

  void removerUsuario(int index) {
    _state.usuarios.removeAt(index);
    notifyListeners();
  }

  void navegaCriarUsuario(BuildContext context, {Usuario? usuario}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CadastrarUsuarioContent(usuario: usuario);
    }));
  }

  Function(int) onTabTapped(
      BuildContext context, int index, TipoUsuario tipoUsuario) {
    if (index == 1 && tipoUsuario == TipoUsuario.TREINADOR) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
                height: 250,
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
                                icone: Icons.sports_handball_outlined,
                                texto: 'Cadastrar Atleta',
                                onPressed: () => {}),
                            BottomSheetButton(
                                icone: Icons.sports,
                                texto: 'Cadastrar Treinador',
                                onPressed: () => {}),
                            BottomSheetButton(
                                icone: Icons.create,
                                texto: 'Cadastrar Treino',
                                onPressed: () => {}),
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
    return const AtletaTreinoContent();
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Perfil'));
  }
}
