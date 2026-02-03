import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotosGridViewer extends StatelessWidget {
  final List<XFile> images;

  const PhotosGridViewer({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // ✨ ارتفاع محدد علشان الجريد يسكروول جواه
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: images.isEmpty
          ? const Center(
              child: Text(
                "لا توجد صور لعرضها",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : GridView.builder(
              physics: const BouncingScrollPhysics(), // ✨ سكرول
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(images[index].path),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}
