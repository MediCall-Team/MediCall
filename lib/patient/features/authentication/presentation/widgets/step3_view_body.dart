import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/image_picker_helper.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_botton2.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/photoes.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/steps.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/upload_photoes_botton.dart';
import 'package:image_picker/image_picker.dart';

class Step3ViewBody extends StatefulWidget {
  Step3ViewBody({super.key});

  @override
  State<Step3ViewBody> createState() => _Step3ViewBodyState();
}

class _Step3ViewBodyState extends State<Step3ViewBody> {
  List<XFile> photos = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            Container(
              height: 40,
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/medicall2(1)(1).png",
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 25),
            Steps(num: 3),

            Text(
              "رفع الشهادات",
              style: TextStyle(
                color: secColor,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),

            SizedBox(height: 25),
            UploadPhotoesBotton(
              onPressed: () async {
                final picked = await pickMultipleImages();
                setState(() {
                  photos = picked; // ✨ تحديث الصور
                });
              },
              text: "رفع الصور",
            ),

            SizedBox(height: 30),

            Expanded(child: PhotosGridViewer(images: photos)),
            SizedBox(height: 60),
            Row(
              children: [
                CustomButton2(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  text: 'رجوع',
                ),
                Spacer(),
                CustomButton2(
                  onPressed: () {
                    //
                  },
                  text: 'أنشاء حساب',
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
