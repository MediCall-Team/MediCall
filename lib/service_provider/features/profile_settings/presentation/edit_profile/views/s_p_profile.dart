import 'package:flutter/material.dart';
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
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_state.dart';

class SPProfile extends StatelessWidget {
  const SPProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<GitSPCubit, GitSPState>(
        builder: (context, state) {
          if (state is GitSPLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF35AAD5)),
            );
          } else if (state is GitSPFailure) {
            return Center(child: Text(state.errMessage));
          } else if (state is GitSPSuccess) {
            final profile = state.profile; // الداتا الحقيقية

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // صورة البروفايل
                  CircleAvatar(
                    radius: (screenWidth * 0.18).clamp(40, 140),
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        (profile.image != null && profile.image!.isNotEmpty)
                        ? NetworkImage(profile.image!)
                        : const AssetImage('assets/images/tempphoto.png')
                              as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  // داخل الـ Column بدل Text(profile.email) مباشرة
                  Text(
                    '${profile.firstName ?? ''} ${profile.lastName ?? ''}'
                            .trim()
                            .isEmpty
                        ? 'الاسم غير متوفر'
                        : ' ${profile.firstName ?? ''} ${profile.lastName ?? ''}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F3E6C),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    profile.email ?? '',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),

                  const SizedBox(height: 50),
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
                            icon: Icons.flag_outlined,
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
                              GoRouter.of(context).push(
                                AppRouter.kServiceProviderProfile,
                                extra: 7,
                              );
                            },
                          ),
                          divider(),
                          BlocConsumer<LogoutCubit, LogoutState>(
                            listener: (context, state) {
                              if (state is LogoutFailure) {
                                snackBarMethod(context, state.errorMsg);
                              } else if (state is LogoutSuccess) {
                                Future.microtask(() async {
                                  await CacheHelper.removeData(key: fcmSentKey);
                                  await CacheHelper.removeData(
                                    key: fcmTokenKey,
                                  );
                                  await CacheHelper.removeUser();
                                  GoRouter.of(context).go(AppRouter.kLoginPage);
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
            );
          }
          return const SizedBox(); // الحالة الابتدائية
        },
      ),
    );
  }
}
