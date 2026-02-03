import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageButton extends StatefulWidget {
  const UploadImageButton({super.key});

  @override
  State<UploadImageButton> createState() => _UploadImageButtonState();
}

class _UploadImageButtonState extends State<UploadImageButton> {
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: secColor, width: 2),
            ),
            child: ClipOval(
              child: selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    )
                  : Center(
                      child: Image.asset(
                        'assets/images/image6.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "رفع صورة",
            style: TextStyle(
              color: secColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
