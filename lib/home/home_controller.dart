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
                height: 300,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Criar', style: TextStyle(fontSize: 20)),
                      const Spacer(),
                      BottomSheetButton(
                          icone: Icons.sports_handball_outlined,
                          texto: 'Cadastrar Atleta',
                          onPressed: () => {}),
                      const Spacer(),
                      BottomSheetButton(
                          icone: Icons.sports,
                          texto: 'Cadastrar Treinador',
                          onPressed: () => {}),
                      const Spacer(),
                      BottomSheetButton(
                          icone: Icons.create,
                          texto: 'Cadastrar Treino',
                          onPressed: () => {}),
                      const Spacer(),
                    ],
                  ),
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
    return const AtletaTreinoContent();
  }
}
