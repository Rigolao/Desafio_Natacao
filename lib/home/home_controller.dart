import 'package:flutter/material.dart';

import '../atletas_treino/atletas_treino_content.dart';
import '../entity/tipo_usuario.dart';
import '../entity/usuario.dart';
import '../treino/treino_content.dart';
import 'components/bottom_sheet_button.dart';
import 'home_state.dart';

class HomeController extends ChangeNotifier {
  final state = HomeState(
      'Treinos',
      0,
      [
        const TreinoContent(),
        Page2(),
        Page3(),
      ],
      Usuario(
          nome: 'Matheus',
          email: 'mrigolao@gmail.com',
          senha: '123456',
          tipoUsuario: TipoUsuario.TREINADOR));

  HomeState get _state => state;

  Function(int) onTabTapped(BuildContext context, int index) {
    if (index == 1 && _state.usuario.tipoUsuario == TipoUsuario.TREINADOR) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          const Text('Criar', style: TextStyle(fontSize: 20, color: Colors.black)),
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
    });    return (index) => onTabTapped(context, index);
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
    return const Center(
      child: Text('Perfil')
    );
  }
}
