import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserImageProfile extends StatefulWidget {
  final bool canEdit;
  final String? imageUrl;
  final Function(File)? onImageSelected;
  final VoidCallback? onRemoveImage;

  const UserImageProfile({
    super.key,
    this.canEdit = false,
    this.imageUrl,
    this.onImageSelected,
    this.onRemoveImage,
  });

  @override
  State<UserImageProfile> createState() => _UserImageProfileState();
}

class _UserImageProfileState extends State<UserImageProfile> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  /// اختيار الصورة
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image == null) return;

    /// crop
    final cropped = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "تعديل الصورة",
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
        ),
        IOSUiSettings(title: "تعديل الصورة"),
      ],
    );

    if (cropped == null) return;

    final file = File(cropped.path);

    setState(() {
      selectedImage = file;
    });

    widget.onImageSelected?.call(file);
  }
 
  /// حذف الصورة
  void removeImage() {
    setState(() {
      selectedImage = null;
    });

    widget.onRemoveImage?.call();
  }

  /// BottomSheet
  void showImageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),

              const Text(
                "اختيار صورة",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("الكاميرا"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("المعرض"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),

              /// يظهر لو في صورة
              if (selectedImage != null ||
                  (widget.imageUrl != null && widget.imageUrl!.isNotEmpty))
                
                if(widget.imageUrl != "https://medicall2026.runasp.net/ImageProfiles/default.jpg")
                  
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    "حذف الصورة",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    removeImage();
                  },
                ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (selectedImage != null) {
      imageProvider = FileImage(selectedImage!);
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(widget.imageUrl!);
    }

    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.blue.shade100.withOpacity(.4),
            backgroundImage: imageProvider,
            child: imageProvider == null
                ? const Icon(Icons.person, size: 60, color: Colors.grey)
                : null,
          ),

          /// زرار التعديل
          if (widget.canEdit)
            GestureDetector(
              onTap: showImageOptions,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 6),
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