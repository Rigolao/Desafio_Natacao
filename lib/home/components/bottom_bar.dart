import 'package:flutter/material.dart';

import '../../entity/tipo_usuario.dart';
import '../../entity/usuario.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final Usuario usuario;

  const BottomBar(this.currentIndex, this.onTabTapped, this.usuario, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items:
      usuario.tipoUsuario == TipoUsuario.TREINADOR ?
      [
        const BottomNavigationBarItem(
          icon: Icon(Icons.sports),
          label: 'Treino',
        ),
        BottomNavigationBarItem(
          icon: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Icon(Icons.add_circle_outline, size: 40),
            ),
          ),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ] :
      usuario.tipoUsuario == TipoUsuario.ATLETA ? [
        const BottomNavigationBarItem(
          icon: Icon(Icons.sports),
          label: 'Meus Treinos',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Historico',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ] :
      [],

    );
  }
}