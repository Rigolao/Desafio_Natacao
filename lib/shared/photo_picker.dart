import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PhotoPicker extends StatelessWidget {
  final String title;
  final Function changeImage;

  const PhotoPicker({super.key, required this.title, required this.changeImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16.0)),
        const Divider(),
        ElevatedButton(
          onPressed: () {
            FilePicker.platform.pickFiles().then((value) {
              if (value != null) {
                changeImage(value.files.single.path!);
              }
            });
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt),
              const SizedBox(width: 8.0),
              Text(title),
            ],
          ),
        ),
      ],
    );
  }
}
