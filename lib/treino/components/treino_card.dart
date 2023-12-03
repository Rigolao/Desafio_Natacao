import 'package:flutter/material.dart';

class TreinoCard extends StatelessWidget {
  const TreinoCard({super.key});

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                leading: Icon(Icons.person),
                title: Text('Treino X'),
                subtitle: Text('Vallada'),
                trailing: Icon(Icons.add),
              ),
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                    AssetImage('assets/images/nado.jpeg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const ListTile(
                title: Text('Horario: 12:00'),
                subtitle: Text('Participantes: 33'),
              ),
              const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor'),
              Align(
                  alignment: Alignment.bottomRight,
                  child: FilledButton(
                      onPressed: () => {},
                          //controller.participar(context),
                      child: const Text('Participar')))
            ],
          )),
    );
  }
}
