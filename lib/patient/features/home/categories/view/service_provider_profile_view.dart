import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/add_review/add_review_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/create_request/create_request_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/MoreReviewRepo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/service_provider_profile/service_provider_profile_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/when_add_review/when_add_review_cubit.dart';
import 'package:grad_project/patient/features/home/categories/widgets/servire_provider_profile_view_body.dart';

class ServiceProviderProfileView extends StatelessWidget {
  const ServiceProviderProfileView({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => ServiceProviderProfileCubit(getIt<CategoriesRepo>()),),
        BlocProvider(create: (context)=>AddReviewCubit(getIt<CategoriesRepo>())),
         BlocProvider(create: (context)=>CreateRequestCubit(getIt<CategoriesRepo>())),
         BlocProvider(create: (context)=>WhenAddReviewCubit(getIt<MoreReviewRepo>()))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "بيانات الدكتور",
            style: Styles.textStyle25.copyWith(
              color: AppTheme.mainContrast(context),
            ),
          ),
        ),
        body: SafeArea(child: ServireProviderProfileViewBody(id: id)),
      ),
    );
  }
}
