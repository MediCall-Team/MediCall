import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/patient/features/profile/presentation/view_model/get_profile_cubit/get_profile_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/views/sick%20record.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/user_image_profile.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/user_info.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileCubit, GetProfileState>(
      builder: (context, state) {

        // ⏳ Loading
        if (state is GetProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // ❌ Error
        if (state is GetProfileFailure) {
          return const Center(child: Text("حصل خطأ"));
        }

        // ✅ Success
        if (state is GetProfileSuccess) {
          final profile = state.profile;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),

                // صورة البروفايل
                UserImageProfile(
                  canEdit: true,
                  imageUrl: profile.profilePictureUrl, // 👈 لو عندك
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
                        UserInfo(
                          icon: Icons.person_outlined,
                          title:
                              "${profile.firstName} ${profile.lastName}", // 👈 الاسم
                          trailing: Icons.edit_outlined,
                          onTap: () {},
                        ),

                        divider(),

                        UserInfo(
                          icon: Icons.phone_outlined,
                          flibx: true,
                          title: profile.phoneNumber, // 👈 الموبايل
                          trailing: Icons.edit_outlined,
                          onTap: () {},
                        ),

                        divider(),

                        UserInfo(
                          icon: Icons.assignment_outlined,
                          title: 'السجل المرضي',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MedicalRecordView(),
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

        // default
        return const SizedBox();
      },
    );
  }
}

// Divider reusable
Widget divider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 32.0),
  child: Divider(height: .3, color: Color(0xffCFEAF5)),
);