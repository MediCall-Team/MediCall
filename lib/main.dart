import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';
import 'package:grad_project/common/chat/presentation/view_model/messages_list/messages_list_cubit.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/services/noti/local_notification_services.dart';
import 'package:grad_project/core/utils/services/noti/push_notification_services.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/logout_cubit/logout_cubit.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';
import 'package:grad_project/patient/features/home/presentation/view_models/cubit/app_theme_cubit.dart';
import 'package:grad_project/patient/features/notification/presentation/view_model/notification_number/notification_number_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  await CacheHelper.init();
  await Firebase.initializeApp();
  await LocalNotificationService.init();
  PushNotificationServices.init();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppThemeCubit()),
          BlocProvider(create: (context) => getIt<NotificationNumberCubit>()),
          BlocProvider(
            create: (context) => LogoutCubit(getIt<PatienAuthRepo>()),
          ),
      
      BlocProvider<MessagesListCubit>(
      create: (context) => getIt<MessagesListCubit>(), // استخدمي getIt هنا
    ),
    BlocProvider<ChatsLitsCubit>(
      create: (context) => getIt<ChatsLitsCubit>(), // واستخدمي getIt هنا كمان
    ),
        ],
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
        final themeMode = state is AppThemeDark
            ? ThemeMode.dark
            : ThemeMode.light;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          scrollBehavior: const NoGlowScrollBehavior(),
          locale: const Locale("ar"),
          routerConfig: AppRouter.router,

          // 🔹 التعديل هنا: نمرر الثيم مع التأكيد على شفافية الـ surfaceTintColor
          theme: AppTheme.lightTheme.copyWith(
            appBarTheme: AppTheme.lightTheme.appBarTheme.copyWith(
              surfaceTintColor: Colors.transparent,
            ),
          ),
          darkTheme: AppTheme.darkTheme.copyWith(
            appBarTheme: AppTheme.darkTheme.appBarTheme.copyWith(
              surfaceTintColor: Colors.transparent,
            ),
          ),
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
