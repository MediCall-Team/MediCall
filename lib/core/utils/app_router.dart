import 'package:go_router/go_router.dart';
import 'package:grad_project/features/authentication/presentation/views/forget_password/screens/ResetPasswordScreen.dart';
import 'package:grad_project/features/authentication/presentation/views/forget_password/screens/forgot_pass_screen.dart';
import 'package:grad_project/features/authentication/presentation/views/forget_password/screens/pass_code.dart';
import 'package:grad_project/features/authentication/presentation/views/login_view.dart';
import 'package:grad_project/features/authentication/presentation/views/sign_up_view.dart';
import 'package:grad_project/features/authentication/presentation/views/step2_view.dart';
import 'package:grad_project/features/authentication/presentation/views/step3_view.dart';
import 'package:grad_project/features/bottom_nav/bottom_nav_view.dart';
import 'package:grad_project/features/bottom_nav/custom_bottom_nav_view.dart';
import 'package:grad_project/features/home/categories/view/service_provider_view.dart';
import 'package:grad_project/features/onboarding/presentation/views/choice_page_view.dart';
import 'package:grad_project/features/onboarding/presentation/views/onbarding_page_view.dart';
import 'package:grad_project/features/onboarding/presentation/views/splash_view.dart';
import 'package:grad_project/features/onboarding/presentation/views/start_now_view.dart';

abstract class AppRouter {
  static const String kStartNow = "/start_now";
  static const String kOnboardingPages = "/onboarding_pages";
  static const String kChoicePage = "/choice_page";
  static const String kBottomNavPage ="/bottom_nav_pag";
  static const String kCustomBottomNavPage ="/custom_bottom_nav_pag";
  static const String kLoginPage = "/login_page";
  static const String kSignUp = "/sign_up_page";
  static const String kSign2Up = "/sign_up_steptwo_page";
  static const String kSign3Up = "/sign_up_stepthree_page";
  static const String forgetpass = "/forget_password_page";
  static const String kPassCode = "/pass_code_page";
  static const String kResetPassword = "/reset_password_page";
   static const String kServiceProvider = "/service_provider_page";
  
  static final router = GoRouter(
    routes: [
    // GoRoute(path: "/", builder: (context, state) => SplashView()),

      // GoRoute(
      //   path: "/",//kBottomNavPage,
      //   builder: (context, state) => BottomNavView(),
      // ),

        GoRoute(
        path: "/",// kCustomBottomNavPage
        builder: (context, state) => CustomBottomNavView(),
      ),

      GoRoute(path: kStartNow, builder: (context, state) => StartNowView()),
      GoRoute(
        path: kOnboardingPages,
        builder: (context, state) => OnboardingPageView(),
      ),
      GoRoute(path: kChoicePage, builder: (context, state) => ChoicePageView()),
      GoRoute(path: kLoginPage, builder: (context, state) => LoginView()),
      GoRoute(path: kSignUp, builder: (context, state) => SignUpView()),
      GoRoute(path: kSign2Up, builder: (context, state) => Step2View()),
      GoRoute(path: kSign3Up, builder: (context, state) => Step3View()),
      GoRoute(path: forgetpass, builder: (context, state) => ForgotPasswordScreen()),
      GoRoute(path: kPassCode, builder: (context, state) => VerificationCodeScreen()),
      GoRoute(path: kResetPassword, builder: (context, state) => ResetPasswordScreen()),
GoRoute(
  path: kServiceProvider,
  builder: (context, state) {
    final cName = state.extra as String;
    return ServiceProviderView(cName:cName);
  },
),

    ],
  );
}
