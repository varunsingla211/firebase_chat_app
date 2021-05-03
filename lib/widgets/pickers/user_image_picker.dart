import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePick;
  UserImagePicker(this.imagePick);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File pickedImage;
  void pickImage() async {
    final pickedImageFile =
        await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150,);
    setState(() {
      pickedImage = pickedImageFile;
    });
    widget.imagePick(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: pickedImage != null ? FileImage(pickedImage) : null,
        ),
        TextButton(
          onPressed: pickImage,
          child: Text('add image'),
        ),
      ],
    );
  }
}
