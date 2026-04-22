import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/logout_cubit/logout_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_loading_indecator.dart';
import 'package:grad_project/patient/features/profile/presentation/view_model/get_profile_cubit/get_profile_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/view_model/get_reports/get_reports_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/view_model/update_profile_cubit/update_profile_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/views/sick%20record.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/user_image_profile.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/user_info.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  String? editedFirstName;
  String? editedLastName;
  String? editedPhone;
  File? selectedImage;

  String? validatePhone(String value) {
    if (value.isEmpty) return "من فضلك ادخل رقم الهاتف";
    final regex = RegExp(r'^(010|011|012|015)\d{8}$');
    if (!regex.hasMatch(value)) return "رقم غير صحيح";
    return null;
  }

  String? validateName(String value) {
    if (value.trim().isEmpty) return "الحقل مطلوب";
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return "لا يجب إدخال أرقام";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is UpdateProfileSuccess) {
          Navigator.pop(context);

          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(const SnackBar(content: Text("تم التعديل بنجاح")));
          snackBarMethod(context, "تم التعديل بنجاح");

          context.read<GetProfileCubit>().getPatProfile();
        } else if (state is UpdateProfilefailure) {
          Navigator.pop(context);

          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(const SnackBar(content: Text("حصل خطأ")));
          snackBarMethod(context, "حصل خطأ");
        }
      },
      child: BlocBuilder<GetProfileCubit, GetProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetProfileFailure) {
            return const Center(child: Text("حصل خطأ"));
          }

          if (state is GetProfileSuccess) {
            final profile = state.profile;

            final firstName = editedFirstName ?? profile.firstName;
            final lastName = editedLastName ?? profile.lastName;
            final phone = editedPhone ?? profile.phoneNumber;

            return CustomLoadingIndicator(
              isLoading: context.watch<LogoutCubit>().loading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    /// صورة البروفايل
                    UserImageProfile(
                      canEdit: true,
                      imageUrl: profile.profilePictureUrl,
                      onImageSelected: (image) {
                        selectedImage = image;

                        context.read<UpdateProfileCubit>().updatePatProfile(
                          firstName: firstName,
                          lastName: lastName,
                          phoneNumber: phone,
                          image: image,
                          isImageRemoved: false,
                        );
                      },
                      onRemoveImage: () {
                        selectedImage = null;

                        context.read<UpdateProfileCubit>().updatePatProfile(
                          firstName: firstName,
                          lastName: lastName,
                          phoneNumber: phone,
                          image: null,
                          isImageRemoved: true,
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    Text(
                      profile.email,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffEDF7FB),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            /// تعديل الاسم
                            UserInfo(
                              icon: Icons.person_outlined,
                              title: "$firstName $lastName",
                              trailing: Icons.edit_outlined,
                              onEditTap: () {
                                final firstController = TextEditingController(
                                  text: firstName,
                                );
                                final lastController = TextEditingController(
                                  text: lastName,
                                );

                                final formKey = GlobalKey<FormState>();

                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("تعديل الاسم"),
                                    content: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: firstController,
                                            decoration: const InputDecoration(
                                              hintText: "الاسم الأول",
                                            ),
                                            validator: (v) => validateName(v!),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            controller: lastController,
                                            decoration: const InputDecoration(
                                              hintText: "الاسم الأخير",
                                            ),
                                            validator: (v) => validateName(v!),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("إلغاء"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            final first = firstController.text
                                                .trim();
                                            final last = lastController.text
                                                .trim();

                                            setState(() {
                                              editedFirstName = first;
                                              editedLastName = last;
                                            });

                                            context
                                                .read<UpdateProfileCubit>()
                                                .updatePatProfile(
                                                  firstName: first,
                                                  lastName: last,
                                                  phoneNumber: phone,
                                                  image: selectedImage,
                                                  isImageRemoved: false,
                                                );

                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text("حفظ"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            divider(),

                            /// تعديل الهاتف
                            UserInfo(
                              icon: Icons.phone_outlined,
                              flibx: true,
                              title: phone,
                              trailing: Icons.edit_outlined,
                              onEditTap: () {
                                final controller = TextEditingController(
                                  text: phone,
                                );
                                final formKey = GlobalKey<FormState>();

                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("تعديل الهاتف"),
                                    content: Form(
                                      key: formKey,
                                      child: TextFormField(
                                        controller: controller,
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                          hintText: "اكتب الرقم الجديد",
                                        ),
                                        validator: (v) => validatePhone(v!),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("إلغاء"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              editedPhone = controller.text;
                                            });

                                            context
                                                .read<UpdateProfileCubit>()
                                                .updatePatProfile(
                                                  firstName: firstName,
                                                  lastName: lastName,
                                                  phoneNumber: controller.text,
                                                  image: selectedImage,
                                                  isImageRemoved: false,
                                                );

                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text("حفظ"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            divider(),

                            UserInfo(
                              icon: Icons.assignment_outlined,
                              title: 'السجل المرضي',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (context) => GetReportsCubit(
                                        getIt<PatientProfileRepo>(),
                                      ),
                                      child: const MedicalRecordView(),
                                    ),
                                  ),
                                );
                              },
                            ),

                            divider(),
                            UserInfo(
                              icon: Icons.info_outline,
                              title: 'عن التطبيق',
                              onTap: () {
                                GoRouter.of(context).push(AppRouter.kAboutApp);
                              },
                            ),
                            divider(),
                            UserInfo(
                              icon: Icons.flag_outlined,
                              title: 'إبلاغ',
                              onTap: () => _showReportDialog(context),
                            ),
                            divider(),

                            BlocConsumer<LogoutCubit, LogoutState>(
                              listener: (context, state) {
                                if (state is LogoutFailure) {
                                  snackBarMethod(context, state.errorMsg);
                                } else if (state is LogoutSuccess) {
                                  Future.microtask(() async {
                                    await CacheHelper.removeData(
                                      key: fcmSentKey,
                                    );
                                    await CacheHelper.removeData(
                                      key: fcmTokenKey,
                                    );
                                    await CacheHelper.removeUser();

                                    GoRouter.of(
                                      context,
                                    ).go(AppRouter.kLoginPage);
                                  });
                                }
                              },
                              builder: (context, state) {
                                return UserInfo(
                                  icon: Icons.logout,
                                  title: 'تسجيل الخروج',
                                  onTap: () async {
                                    final deviceIdd = await CacheHelper.getData(
                                      key: deviceId,
                                    );

                                    if (deviceIdd != null) {
                                      BlocProvider.of<LogoutCubit>(
                                        context,
                                      ).logOut(deviceId: deviceIdd);
                                    } else {
                                      await CacheHelper.removeUser();
                                      GoRouter.of(
                                        context,
                                      ).go(AppRouter.kLoginPage);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    final TextEditingController reportController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // أيقونة
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flag_outlined,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),

              // العنوان
              const Text(
                "إبلاغ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal",
                  color: Color(0xff1F3E6C),
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "اكتب تفاصيل البلاغ وسيتم إرساله مباشرةً",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: "Tajawal",
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              // حقل الكتابة
              TextFormField(
                controller: reportController,
                maxLines: 4,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "اكتب بلاغك هنا...",
                  hintStyle: const TextStyle(
                    fontFamily: "Tajawal",
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xff1F3E6C),
                      width: 0.8,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xff40B1D8),
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // الأزرار
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(
                          color: Color(0xff1F3E6C),
                          width: 0.8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "إلغاء",
                        style: TextStyle(
                          fontFamily: "Tajawal",
                          color: Color(0xff1F3E6C),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final message = reportController.text.trim();
                        if (message.isEmpty) return;

                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: 'medicall392026@gmail.com',
                          query: Uri.encodeFull(
                            'subject=بلاغ من التطبيق&body=$message',
                          ),
                        );

                        if (await canLaunchUrl(emailUri)) {
                          await launchUrl(emailUri);
                          if (dialogContext.mounted) {
                            Navigator.pop(dialogContext);
                          }
                        } else {
                          if (dialogContext.mounted) {
                            snackBarMethod(
                              dialogContext,
                              "لا يوجد تطبيق بريد إلكتروني مثبت",
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff40B1D8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "إرسال",
                        style: TextStyle(
                          fontFamily: "Tajawal",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget divider() => const Padding(
  padding: EdgeInsets.symmetric(horizontal: 32),
  child: Divider(height: .3, color: Color(0xffCFEAF5)),
);
