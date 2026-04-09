import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/authentication/presentation/view_model/logout_cubit/logout_cubit.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/views/edit_s_p_view.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/views/s_p_profile.dart';
import 'package:grad_project/service_provider/features/requests/repos/Service_profile_Repo.dart';

class SPProfileSettings extends StatelessWidget {
  const SPProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LogoutCubit(getIt<PatienAuthRepo>()),
          ),

          // 🔹 إضافة البلوك بروفايدر واستدعاء الدالة فوراً
          BlocProvider(
            create: (context) =>
                GitSPCubit(SPProfileRepoImpl(getIt<ApiConsumer>()))
                  ..getProviderProfile(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text("بيانات الدكتور", style: Styles.textStyle25),
            actions: [
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      final cubit = context.read<GitSPCubit>();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: const EditSPView(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: SafeArea(child: SPProfile()),
        ),
      ),
    );
  }
}
