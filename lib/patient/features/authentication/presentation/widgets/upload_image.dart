import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:grad_project/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageButton extends StatefulWidget {
  final Function(File) onImageSelected;

  const UploadImageButton({super.key, required this.onImageSelected});

  @override
  State<UploadImageButton> createState() => _UploadImageButtonState();
}

class _UploadImageButtonState extends State<UploadImageButton> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  /// ضغط الصورة
  Future<File> compressImage(File file) async {
    final targetPath = "${file.path}_compressed.jpg";

    final compressed = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70, // نسبة الضغط
    );

    return File(compressed!.path);
  }

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

    File file = File(cropped.path);

    /// ضغط الصورة
    file = await compressImage(file);

    setState(() {
      selectedImage = file;
    });

    widget.onImageSelected(file);
  }

  /// اختيار المصدر
  void openPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("المعرض"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("الكاميرا"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openPicker,
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