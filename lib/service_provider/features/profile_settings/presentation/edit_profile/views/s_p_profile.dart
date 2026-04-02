import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/logout_cubit/logout_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/user_info.dart';
class SPProfile extends StatelessWidget {
  const SPProfile({super.key});

  @override
  
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('الملف الشخصي', style: Styles.textStyle25)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // صورة البروفايل
            CircleAvatar(
          radius: (screenWidth * 0.18).clamp(40, 140), //80,
          backgroundImage: AssetImage('assets/images/tempphoto.png'),
        ),
            const SizedBox(height: 10),
            Text(
              'Hamza1@gmail.com',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffEDF7FB),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    UserInfo(
                      icon: Icons.flag_outlined,
                      //report_gmailerrorred_outlined,
                      //report_outlined
                      title: 'إبلاغ',
                      onTap: () {},
                    ),
                    divider(),
                    UserInfo(
                      icon: Icons.info_outline,
                      title: 'عن التطبيق',
                      onTap: () {},
                    ),
                    divider(),
                      UserInfo(
                      icon: Icons.info_outline,
                      title: "عرض كما يظهر للأخرين",
                      onTap: () {
                         GoRouter.of(context).push(AppRouter.kServiceProviderProfile,extra:7 );
                      },
                    ),
                    divider(),
                  
                  
                            BlocConsumer<LogoutCubit, LogoutState>(
                              listener: (context, state) {
                                if (state is LogoutFailure) {
                                  snackBarMethod(
                                    context,
                                    state.errorMsg ,
                                  );
                                } else if (state is LogoutSuccess) {
                                  // 🔹 نستخدم microtask عشان listener ما يكونش async
                                  Future.microtask(() async {
                                    // إزالة الـ FCM token من الكاش
                                    await CacheHelper.removeData(
                                      key: fcmSentKey,
                                    );
                                    await CacheHelper.removeData(
                                      key: fcmTokenKey,
                                    );

                                    // إزالة بيانات المستخدم
                                    await CacheHelper.removeUser();

                                    // الانتقال للصفحة الرئيسية
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
                                    // 🔹 جلب الـ FCM token من الكاش
                                    final deviceIdd = await CacheHelper.getData(
                                      key: deviceId,
                                    );
                                    if (deviceIdd != null) {
                                      BlocProvider.of<LogoutCubit>(
                                        context,
                                      ).logOut(deviceId: deviceIdd);
                                    } else {
                                      // لو مفيش token، ممكن نعمل logout محلي بس
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
}
