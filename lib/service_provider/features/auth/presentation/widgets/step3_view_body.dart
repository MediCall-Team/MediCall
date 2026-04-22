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
import 'package:grad_project/service_provider/features/auth/presentation/view_model/sp_register_cubit/sp_register_cubit.dart';
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
          snackBarMethod(
            context,
            "سيتم التأكد من بياناتك وسوف تصلك رسالة تأكيد على بريدك الألكتروني",
          );

          Navigator.popUntil(context, (route) => route.isFirst);
        }

        if (state is SpRegisterFailure) {
          snackBarMethod(context, state.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is SpRegisterLoading;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              Padding(
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

                    const SizedBox(height: 25),
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

                    const SizedBox(height: 25),

                    UploadPhotoesBotton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              final picked = await pickMultipleImages();
                              setState(() {
                                photos = picked;
                              });
                            },
                      text: "رفع الصور",
                    ),

                    const SizedBox(height: 30),

                    Expanded(
                      child: PhotosGridViewer(images: photos),
                    ),

                    const SizedBox(height: 60),

                    Row(
                      children: [
                        CustomButton2(
                          onPressed: isLoading
                              ? null
                              : () {
                                  GoRouter.of(context).pop();
                                },
                          text: 'رجوع',
                        ),
                        const Spacer(),
                        CustomButton2(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (photos.isNotEmpty) {
                                    final files = photos
                                        .map((e) => File(e.path))
                                        .toList();

                                    context
                                        .read<SpRegisterCubit>()
                                        .setCertificates(
                                          certificates: files,
                                        );

                                    context
                                        .read<SpRegisterCubit>()
                                        .register();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ReusableDialog(
                                        title: "تنبيه!",
                                        content:
                                            "يجب ان تقوم برفع ما يثبت احقيتك في العمل",
                                      ),
                                    );
                                  }
                                },
                          text: 'إنشاء حساب',
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),

              // 🔥 Loading Overlay
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.4),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}