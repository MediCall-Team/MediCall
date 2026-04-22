import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:url_launcher/url_launcher.dart';
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
                           onTap: () => _showReportDialog(context),
                          ),
                          divider(),
                          UserInfo(
                            icon: Icons.info_outline,
                            title: 'عن التطبيق',
                            onTap: () {
                               GoRouter.of(context).push(AppRouter.kAboutApp);                           },
                          ),
                          divider(),
                          UserInfo(
                            icon: Icons.info_outline,
                            title: "عرض كما يظهر للأخرين",
                            onTap: () {
                              GoRouter.of(context).push(
                                AppRouter.kServiceProviderProfile,
                                extra:int.parse( CacheHelper.getUser()!.id),
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
  void _showReportDialog(BuildContext context) {
  final TextEditingController reportController = TextEditingController();

  showDialog(
    context: context,
    builder: (dialogContext) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
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
                  borderSide: const BorderSide(color: Color(0xff1F3E6C), width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xff40B1D8), width: 1),
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
                      side: const BorderSide(color: Color(0xff1F3E6C), width: 0.8),
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
