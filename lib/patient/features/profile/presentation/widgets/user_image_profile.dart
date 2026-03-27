import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:image_picker/image_picker.dart';

class UserImageProfile extends StatefulWidget {
  final bool canEdit;
  final String? imageUrl;
  final Function(File)? onImageSelected;

  const UserImageProfile({
    super.key,
    this.canEdit = false,
    this.imageUrl,
    this.onImageSelected,
  });

  @override
  State<UserImageProfile> createState() => _UserImageProfileState();
}

class _UserImageProfileState extends State<UserImageProfile> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  /// 📸 اختيار الصورة بدون crop
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final file = File(image.path);

      setState(() {
        selectedImage = file;
      });

      // 🔥 نبعتها للـ parent (عشان الكيوبت)
      widget.onImageSelected?.call(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (selectedImage != null) {
      imageProvider = FileImage(selectedImage!);
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(widget.imageUrl!);
    }
     else {
      imageProvider = const AssetImage('assets/images/tempphoto.png');
    }

    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.blue.shade100.withOpacity(0.4),
            backgroundImage: imageProvider,
          ),

          if (widget.canEdit)
            GestureDetector(
              onTap: pickImage,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
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
