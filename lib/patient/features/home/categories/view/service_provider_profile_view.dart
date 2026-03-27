import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/service_provider_profile/service_provider_profile_cubit.dart';
import 'package:grad_project/patient/features/home/categories/widgets/servire_provider_profile_view_body.dart';

class ServiceProviderProfileView extends StatelessWidget {
  const ServiceProviderProfileView({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceProviderProfileCubit(getIt<CategoriesRepo>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "بيانات الدكتور",
            style: Styles.textStyle25.copyWith(
              color: AppTheme.mainContrast(
                context,
              ), //AppTheme.secondary(context)
            ),
          ),
        ),
        body: SafeArea(
          child: ServireProviderProfileViewBody(
            id: id,
            //  spModel: serviceProviderProfileModel,
          ),
        ),
      ),
    );
  }
}
