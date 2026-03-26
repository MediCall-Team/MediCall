import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/profile/presentation/view_model/get_profile_cubit/get_profile_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => GetProfileCubit(getIt<PatientProfileRepo>())..getPatProfile(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'الملف الشخصي',
              style: Styles.textStyle25.copyWith(
                color: AppTheme.mainContrast(context),
              ),
            ),
          ),

          body: ProfileViewBody(),
        ),
      ),
    );
  }
}
