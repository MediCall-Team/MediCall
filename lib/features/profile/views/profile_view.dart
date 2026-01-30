import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/features/profile/widgets/user_image_profile.dart';
import 'package:grad_project/features/profile/widgets/user_info.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('الملف الشخصي', style: Styles.textStyle25)),

        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),

              // صورة البروفايل
              UserImageProfile(),
              const SizedBox(height: 10),
              Text(
                'Hamza1@gmail.com',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // الكارد اللي فيه البيانات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      UserInfo(
                        icon: Icons.person_outlined,
                        title: 'حمزة طارق',
                        trailing: Icons.edit_outlined,
                        onTap: () {
                          // edit name
                        },
                      ),

                      divider(),
                      UserInfo(
                        icon: Icons.phone_outlined,
                        flibx: true,
                        title: '012345678',
                        trailing: Icons.edit_outlined,
                        onTap: () {
                          // edit phone
                        },
                      ),
                      divider(),
                     
                      UserInfo(
                        icon: Icons.assignment_outlined,
                        title: 'السجل المرضي',
                        trailing: Icons.edit_outlined,
                        onTap: () {
                          // edit name
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
                        //report_gmailerrorred_outlined,
                        //report_outlined
                        title: 'إبلاغ',
                        onTap: () {},
                      ),
                      divider(),

                      UserInfo(
                        icon: Icons.location_on_outlined,
                        title: 'الموقع',
                        onTap: () {},
                      ),
                      divider(),

                      UserInfo(
                        icon: Icons.logout,
                        title: 'تسجيل الخروج',
                        onTap: () {
                          // logout
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
      ),
    );
  }
}

// Divider reusable
Widget divider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 32.0),
  child: Divider(height: .3, color: Colors.blue.shade100),
);
