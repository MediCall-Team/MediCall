import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grad_project/features/authentication/presentation/views/sign_up_view.dart';
import 'package:grad_project/features/authentication/presentation/views/step2_view.dart';
import 'package:grad_project/features/home/views/home_view.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/utils/app_router.dart';
void main() {
  runApp(const MediApp());
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