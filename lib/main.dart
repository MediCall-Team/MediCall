import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/core/utils/app_router.dart';
void main() {
  runApp(
    DevicePreview(builder: (context)=>const MediApp(),enabled: false,)
    );
}


class MediApp extends StatelessWidget {
  const MediApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
      )
      ),
      debugShowCheckedModeBanner: false,

        locale: Locale("ar"),
  routerConfig: AppRouter.router,
        localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
    );
  //   return MaterialApp.router(
  //     debugShowCheckedModeBanner: false,
  //       locale: Locale("ar"),
  // routerConfig: AppRouter.router,
  //       localizationsDelegates: const [
  //               S.delegate,
  //               GlobalMaterialLocalizations.delegate,
  //               GlobalWidgetsLocalizations.delegate,
  //               GlobalCupertinoLocalizations.delegate,
  //             ],
  //             supportedLocales: S.delegate.supportedLocales,
  //   );
  }
}