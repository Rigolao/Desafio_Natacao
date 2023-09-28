import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final bool rating;
  const PersonCard({required this.rating, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Matheus Rigolão'),
          subtitle: const Text('Treinador', style: TextStyle(color: Colors.grey)),
          trailing: rating == true ? FilledButton(onPressed: () => {}, child: Text('AVALIAR')) : null
        ),
      ),
    );
  }
}
