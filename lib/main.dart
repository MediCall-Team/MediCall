import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/patient/features/home/presentation/view_models.dart/cubit/app_theme_cubit.dart';


void main() {
   setupServiceLocator();
   
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => BlocProvider(
        create: (_) => AppThemeCubit(),
        child: const MediApp(),
      ),
    ),
  );
}

class MediApp extends StatelessWidget {
  const MediApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        final themeMode =
            state is AppThemeDark ? ThemeMode.dark : ThemeMode.light;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          scrollBehavior: const NoGlowScrollBehavior(),
          locale: const Locale("ar"),
          routerConfig: AppRouter.router,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,

          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}

/// 🔹 Custom ScrollBehavior لمنع overscroll glow
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