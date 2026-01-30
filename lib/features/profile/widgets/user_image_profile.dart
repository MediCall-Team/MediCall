import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:image_picker/image_picker.dart';

class UserImageProfile extends StatefulWidget {
  UserImageProfile({super.key});

  @override
  State<UserImageProfile> createState() => _UserImageProfileState();
}

class _UserImageProfileState extends State<UserImageProfile> {
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.blue.shade100.withOpacity(0.4),
            backgroundImage: selectedImage != null
                ? FileImage(selectedImage!)
                : const AssetImage('assets/images/tempphoto.png')
                      as ImageProvider,
          ),

          // زر تعديل الصورة
          GestureDetector(
            onTap: () {
              pickImage();
              // TODO: change image
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(6),
              child: Icon(Icons.edit_outlined, color: secColor, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
