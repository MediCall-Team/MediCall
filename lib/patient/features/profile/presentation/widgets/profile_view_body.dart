import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
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

          // 🔥 نعمل refresh للداتا
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  UserImageProfile(
                    canEdit: true,
                    imageUrl: profile.profilePictureUrl,
                    onImageSelected: (image) {
                      selectedImage = image;

                      context.read<UpdateProfileCubit>().updatePatProfile(
                        firstName,
                        lastName,
                        phone,
                        image,
                        true,
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
                          /// 👤 الاسم
                          UserInfo(
                            icon: Icons.person_outlined,
                            title: "$firstName $lastName",
                            trailing: Icons.edit_outlined,
                            onEditTap: () {
                              final controller = TextEditingController(
                                text: "$firstName $lastName",
                              );

                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("تعديل الاسم"),
                                  content: TextField(controller: controller),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("إلغاء"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final parts = controller.text.split(
                                          " ",
                                        );

                                        final first = parts[0];
                                        final last = parts.length > 1
                                            ? parts[1]
                                            : "";

                                        setState(() {
                                          editedFirstName = first;
                                          editedLastName = last;
                                        });

                                        context
                                            .read<UpdateProfileCubit>()
                                            .updatePatProfile(
                                              first,
                                              last,
                                              phone,
                                              null,
                                              false,
                                            );

                                        Navigator.pop(context);
                                      },
                                      child: const Text("حفظ"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          divider(),

                          /// 📞 الموبايل
                          UserInfo(
                            icon: Icons.phone_outlined,
                            flibx: true,
                            title: phone,
                            trailing: Icons.edit_outlined,
                            onEditTap: () {
                              final controller = TextEditingController(
                                text: phone,
                              );

                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("تعديل الهاتف"),
                                  content: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("إلغاء"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          editedPhone = controller.text;
                                        });

                                        context
                                            .read<UpdateProfileCubit>()
                                            .updatePatProfile(
                                              firstName,
                                              lastName,
                                              controller.text,
                                              null,
                                              false,
                                            );

                                        Navigator.pop(context);
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

                          /// ℹ️ عن التطبيق
                          UserInfo(
                            icon: Icons.info_outline,
                            title: 'عن التطبيق',
                            onTap: () {},
                          ),
                          divider(),

                          /// 🚩 إبلاغ
                          UserInfo(
                            icon: Icons.flag_outlined,
                            title: 'إبلاغ',
                            onTap: () {},
                          ),
                          divider(),

                          UserInfo(
                            icon: Icons.logout,
                            title: 'تسجيل الخروج',
                            onTap: () async {
                              await CacheHelper.removeUser();
                              GoRouter.of(context).go("/");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
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
