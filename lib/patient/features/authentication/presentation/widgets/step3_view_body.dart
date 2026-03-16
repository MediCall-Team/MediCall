import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/image_picker_helper.dart';
import 'package:grad_project/core/helper/reusable_dialog.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_botton2.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/photoes.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/steps.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/upload_photoes_botton.dart';
import 'package:grad_project/service_provider/auth/presentation/view_model/sp_register_cubit/sp_register_cubit.dart';
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
    return BlocConsumer<SpRegisterCubit, SpRegisterState>(
      listener: (context, state) {
if (state is SpRegisterSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم إنشاء الحساب بنجاح")),
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    }

    if (state is SpRegisterFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    }      },
      builder: (context, state) {
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
    if(photos.isNotEmpty){
    final files = photos.map((e) => File(e.path)).toList();

    context.read<SpRegisterCubit>().setCertificates(
      certificates: files,
    );

    context.read<SpRegisterCubit>().register();
    }else{
      showDialog(
  context: context,
  builder: (context) => ReusableDialog(
    title: "تنبيه!",
    content: "يجب ان تقوم برفع ما يثبت احقيتك في العمل",
  ),
);
    }
  },
  text: 'إنشاء حساب',
),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
