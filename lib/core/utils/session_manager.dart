import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/app_theme.dart';

class SessionManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static bool _isDialogShowing = false;

  static void handleSessionExpired() {
    if (_isDialogShowing) return;

    final context = navigatorKey.currentContext;
    if (context == null) return;

    _isDialogShowing = true;

    showDialog(
      
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceToGrey(context),
          title: const Text("انتهت صلاحيه الجلسه"),
          content: const Text("قم باعاده تسجيل الدخول"),
          actions: [
            TextButton(
              onPressed: () {
                _isDialogShowing = false;

                // 🧹 امسحي البيانات
                CacheHelper.removeUser(); // أو clear token بس لو عندك method

                // 🔁 روحي للوجين
               GoRouter.of(context).go(AppRouter.kLoginPage);
              },
              child: const Text("حسنا"),
            ),
          ],
        );
      },
    );
  }
}