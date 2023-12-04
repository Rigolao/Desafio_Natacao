import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:desafio_6_etapa/entity/usuario.dart';
import 'package:desafio_6_etapa/shared/batimento_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../animation/HeartbeatIcon.dart';

class PersonCard extends StatelessWidget {
  final bool rating;
  final Usuario usuario;
  final Function()? callback;

  const PersonCard({required this.rating, required this.usuario, super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.person),
              title: Text(usuario!.nome),
              subtitle: Text(
                  usuario!.tipoUsuario == TipoUsuario.ATLETA
                      ? 'Atleta'
                      : usuario!.tipoUsuario == TipoUsuario.TREINADOR
                          ? 'Treinador'
                          : 'Administrador',
                  style: const TextStyle(color: Colors.grey)),
              trailing: rating == true
                  ? CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: IconButton(
                        autofocus: true,
                        focusColor: Colors.blue[200],
                        onPressed: () {
                          if (usuario != null) {
                            _showModal(context, callback);
                          }
                        },
                        icon: const Icon(Icons.timer_outlined),
                      ),
                    )
                  : null,
            )));
  }

  void _showModal(BuildContext context, Function()? callback) {
    TextEditingController _controller = TextEditingController();

    batimentoCard(context, () {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/cronometro', arguments: {
        'atleta': usuario,
        'ritmoInicial': _controller.text,
      }).then((value) => callback);
    }, _controller);
  }
}
