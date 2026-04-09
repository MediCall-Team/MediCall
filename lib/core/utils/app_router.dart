import 'package:dartz/dartz_streaming.dart';
import 'package:flutter/material.dart' show Scaffold, Center, SizedBox;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/session_manager.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/screens/ResetPasswordScreen.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/screens/forgot_pass_screen.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/forget_password/screens/pass_code.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/login_view.dart';
import 'package:grad_project/patient/features/authentication/presentation/views/patient_sign_up_view.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/login_view_body.dart';
import 'package:grad_project/patient/features/home/presentation/views/ai_view.dart';
import 'package:grad_project/service_provider/features/auth/presentation/views/sign_up_view.dart';
import 'package:grad_project/service_provider/features/auth/presentation/views/step2_view.dart';
import 'package:grad_project/service_provider/features/auth/presentation/views/step3_view.dart';
import 'package:grad_project/patient/features/bottom_nav/bottom_nav_view.dart';
import 'package:grad_project/patient/features/bottom_nav/custom_bottom_nav_view.dart';
import 'package:grad_project/patient/features/chats/a_chat/views/a_chat_view.dart';
import 'package:grad_project/patient/features/home/categories/view/more_categories_view.dart';
import 'package:grad_project/patient/features/home/categories/view/service_provider_profile_view.dart';
import 'package:grad_project/patient/features/home/categories/view/service_provider_view.dart';
import 'package:grad_project/common/onboarding/presentation/views/choice_page_view.dart';
import 'package:grad_project/common/onboarding/presentation/views/onbarding_page_view.dart';
import 'package:grad_project/common/onboarding/presentation/views/splash_view.dart';
import 'package:grad_project/common/onboarding/presentation/views/start_now_view.dart';
import 'package:grad_project/patient/features/home/presentation/views/home_view.dart';
import 'package:grad_project/service_provider/features/bottom_nav/presentation/views/s_custom_bottom_nav.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/add_country.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/cubit/updata_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/views/edit_s_p_view.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/views/s_p_profile.dart';
import 'package:grad_project/service_provider/features/requests/repos/Service_profile_Repo.dart';

abstract class AppRouter {
  static const String kStartNow = "/start_now";
  static const String kOnboardingPages = "/onboarding_pages";
  static const String kChoicePage = "/choice_page";
  static const String kBottomNavPage = "/bottom_nav_pag";
  static const String kCustomBottomNavPage = "/custom_bottom_nav_pag";
  static const String kLoginPage = "/login_page";
  static const String kSignUp = "/sign_up_page";
  static const String kSign2Up = "/sign_up_steptwo_page";
  static const String kSign3Up = "/sign_up_stepthree_page";
  static const String kPatientSignUpView = "/kPatient_sign_up_view";
  static const String forgetpass = "/forget_password_page";
  static const String kPassCode = "/pass_code_page";
  static const String kResetPassword = "/reset_password_page";
  static const String kHomeView = "/khome_view";
  static const String kServiceProvider = "/service_provider_page";
  static const String kServiceProviderProfile =
      "/service_provider_profile_page";
  static const String kmoreCategories = "/more_categories_page";
  static const String kSCustomBottomNavPage = "/s_custom_bottom_nav_pag";
  static const String kServiceProviderEditView = "/service_provider_editView";
  static const String kAChat = '/a_chat_view';
  static const String kVerifyCodeView = "/verifyCode";
  static const String kSPProfile = '/s_p_profile_view';
  static const String kAI = '/ai_view';
  static final router = GoRouter(
    navigatorKey: SessionManager.navigatorKey,
    initialLocation: "/",
    redirect: (context, state) {
      final user = CacheHelper.getUser();

      // إحنا بنتدخل فقط لو المستخدم فاتح الصفحة الرئيسية (اللوجين) ومعاه توكن
      final isAtStart = state.matchedLocation == "/";

      if (isAtStart && user != null && user.role == "Patient") {
        return kBottomNavPage; // لو مسجل وديه الهوم فوراً
      } else if (isAtStart && user != null) {
        return kSCustomBottomNavPage;
      }

      // في أي حالة تانية (رايح ساين أب، رايح ينسى الباسورد) سيبه يروح براحته
      return null;
    },

    routes: [
      //splash
      GoRoute(path: "/", builder: (context, state) => SplashView()),

      // GoRoute(
      //   path: "/", //kBottomNavPage,
      //   builder: (context, state) => BottomNavView(),
      // ),

      // patient
      GoRoute(
        path: kBottomNavPage, // kCustomBottomNavPage
        builder: (context, state) => CustomBottomNavView(),
      ),

      // service provider
      GoRoute(
        path: kSCustomBottomNavPage, // kCustomBottomNavPage
        builder: (context, state) => SCustomBottomNav(),
      ),

      GoRoute(path: kStartNow, builder: (context, state) => StartNowView()),
      GoRoute(
        path: kOnboardingPages,
        builder: (context, state) => OnboardingPageView(),
      ),
      GoRoute(path: kChoicePage, builder: (context, state) => ChoicePageView()),
      GoRoute(path: kLoginPage, builder: (context, state) => LoginView()),

      GoRoute(path: kSignUp, builder: (context, state) => SignUpView()),

      //  GoRoute(path: kSign2Up, builder: (context, state) => Step2View()),

      //  GoRoute(path: kSign3Up, builder: (context, state) => Step3View()),
      GoRoute(
        path: kPatientSignUpView,
        builder: (context, state) => PatientSignUpView(),
      ),
      GoRoute(
        path: forgetpass,
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      // GoRoute(
      //   path: kPassCode,
      //   builder: (context, state) {
      //     final email = state.extra as String; // بنستقبل الإيميل من extra
      //     return VerificationCodeScreen(email: email);
      //   },
      // ),
      GoRoute(
        path: kResetPassword,
        builder: (context, state) {
          final email = state.extra as String;
          return ResetPasswordScreen(email: email, code: "");
        },
      ),

      GoRoute(path: kHomeView, builder: (context, state) => HomeView()),
      GoRoute(
        path: kmoreCategories,
        builder: (context, state) => MoreCategoriesView(),
      ),
      GoRoute(
        path: kServiceProviderEditView,
        builder: (context, state) {
          return const EditSPView();
        },
      ),

      GoRoute(path: kAChat, builder: (context, state) => AChatView()),
      GoRoute(
        path: kServiceProvider,
        builder: (context, state) {
          final cName = state.extra as String;
          return ServiceProviderView(cName: cName);
        },
      ),

      GoRoute(
        path: kServiceProviderProfile,
        builder: (context, state) {
          final int id = state.extra as int;
          return ServiceProviderProfileView(id: id);
        },
      ),
      GoRoute(path: kSPProfile, builder: (context, state) => SPProfile()),
      GoRoute(
        path: '/add_country',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          return AddCountry(
            gitCubit: extras['gitCubit'] as GitSPCubit,
            updateCubit: extras['updateCubit'] as UpdataSPCubit,
          );
        },
      ),
    ],
  );
}
