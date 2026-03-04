import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/core/utils/app_router.dart';

void main() {

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MediApp(),
    ),
  );
}

class MediApp extends StatelessWidget {
  const MediApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      // 🔴 إلغاء overscroll glow (اللون الوردي)
      scrollBehavior: const NoGlowScrollBehavior(),

      locale: const Locale("ar"),
      routerConfig: AppRouter.router,

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent, // مهم لأندرويد 12+
        ),
      ),

      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

/// 🔹 Custom ScrollBehavior لمنع اللون الوردي وقت السحب
class NoGlowScrollBehavior extends MaterialScrollBehavior {
  const NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
