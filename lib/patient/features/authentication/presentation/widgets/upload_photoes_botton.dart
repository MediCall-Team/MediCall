import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class UploadPhotoesBotton extends StatelessWidget {
  const UploadPhotoesBotton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
       child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: priColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$text  ',
              style: const TextStyle(
                fontSize: 22,
                fontFamily: "Tajawal",
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(Icons.cloud_upload_outlined,size: 24,),
          ]
      ),
    ));
  }
}
