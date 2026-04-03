import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/logout_cubit/logout_cubit.dart';

class SessionManager {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static bool _isDialogShowing = false;

  static void handleSessionExpired() {
    if (_isDialogShowing) return;

    final context = navigatorKey.currentContext;
    if (context == null) return;

    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        // نستخدم BlocConsumer هنا لمراقبة حالة الـ Logout داخل الـ Dialog
        return BlocConsumer<LogoutCubit, LogoutState>(
          listener: (context, state) async {
            if (state is LogoutSuccess) {
              _isDialogShowing = false;
              
              // 1. مسح البيانات من الكاش عند النجاح
              await CacheHelper.removeData(key: fcmSentKey);
              await CacheHelper.removeData(key: fcmTokenKey);
              await CacheHelper.removeUser();

              // 2. إغلاق الـ Dialog والتوجه لصفحة اللوجين
              if (navigatorKey.currentContext != null) {
                GoRouter.of(navigatorKey.currentContext!).go(AppRouter.kLoginPage);
              }
            } else if (state is LogoutFailure) {
              _isDialogShowing = false;
              Navigator.pop(dialogContext); // إغلاق الدايالوج للسماح بالمحاولة مرة أخرى
              
              // إظهار رسالة خطأ
             snackBarMethod(context, "حاول مرة أخرى.");
            }
          },
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: AppTheme.surfaceToGrey(context),
              title: const Text("انتهت صلاحية الجلسة"),
              content: state is LogoutLoading 
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text("جاري تسجيل الخروج..."),
                      ],
                    )
                  : const Text("انتهت صلاحية الجلسة، برجاء إعادة تسجيل الدخول."),
              actions: [
                if (state is! LogoutLoading)
                  TextButton(
                    onPressed: () async {
                      // جلب الـ Device ID لنده الـ endpoint
                      final deviceIdd = await CacheHelper.getData(key: deviceId);
                      
                      if (deviceIdd != null) {
                        // نداء الـ الـ endpoint الخاص بالـ Logout
                        context.read<LogoutCubit>().logOut(deviceId: deviceIdd);
                      } else {
                        // لو مفيش deviceId نمسح يدوي ونخرج (كحالة احتياطية)
                        await CacheHelper.removeUser();
                        _isDialogShowing = false;
                        GoRouter.of(context).go(AppRouter.kLoginPage);
                      }
                    },
                    child: const Text("حسناً"),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:grad_project/constants.dart';
// import 'package:grad_project/core/helper/chach_helper.dart';
// import 'package:grad_project/core/utils/app_router.dart';
// import 'package:grad_project/core/utils/app_theme.dart';

// class SessionManager {
//   static final GlobalKey<NavigatorState> navigatorKey =
//       GlobalKey<NavigatorState>();

//   static bool _isDialogShowing = false;

//   static void handleSessionExpired() {
//     if (_isDialogShowing) return;

//     final context = navigatorKey.currentContext;
//     if (context == null) return;

//     _isDialogShowing = true;

//     showDialog(
      
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: AppTheme.surfaceToGrey(context),
//           title: const Text("انتهت صلاحيه الجلسه"),
//           content: const Text("قم باعاده تسجيل الدخول"),
//           actions: [
//             TextButton(
//               onPressed: ()async {
//                 _isDialogShowing = false;
              
//                 await CacheHelper.removeData(
//                                       key: fcmSentKey,
//                                     );
//                                     await CacheHelper.removeData(
//                                       key: fcmTokenKey,
//                                     );
//                 // 🧹 امسحي البيانات
//               await  CacheHelper.removeUser(); // أو clear token بس لو عندك method
                
//                 // 🔁 روحي للوجين
//                GoRouter.of(context).go(AppRouter.kLoginPage);
//               },
//               child: const Text("حسنا"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }