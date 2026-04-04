import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/logout_cubit/logout_cubit.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_loading_indecator.dart';
import 'package:grad_project/patient/features/profile/presentation/view_model/get_profile_cubit/get_profile_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/view_model/update_profile_cubit/update_profile_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/views/sick%20record.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/user_image_profile.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/user_info.dart';

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

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("تم التعديل بنجاح")));

          context.read<GetProfileCubit>().getPatProfile();
        } else if (state is UpdateProfilefailure) {
          Navigator.pop(context);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("حصل خطأ")));
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
                                    builder: (_) => const MedicalRecordView(),
                                  ),
                                );
                              },
                            ),

                            divider(),
                            UserInfo(
                              icon: Icons.info_outline,
                              title: 'عن التطبيق',
                              onTap: () {},
                            ),
                            divider(),
                            UserInfo(
                              icon: Icons.flag_outlined,
                              title: 'إبلاغ',
                              onTap: () {},
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
}

Widget divider() => const Padding(
  padding: EdgeInsets.symmetric(horizontal: 32),
  child: Divider(height: .3, color: Color(0xffCFEAF5)),
);
