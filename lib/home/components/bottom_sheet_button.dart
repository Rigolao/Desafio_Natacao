import 'package:flutter/material.dart';

class BottomSheetButton extends StatelessWidget {
  final IconData icone;
  final String texto;
  final Function() onPressed;
  const BottomSheetButton({required this.icone, required this.texto, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xD0DCDCDC),
            ),
            child: Center(
              child: Icon(
                icone,
                size: 25,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Text(texto, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
