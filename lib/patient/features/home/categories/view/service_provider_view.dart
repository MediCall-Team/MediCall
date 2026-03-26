import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/filter_cubit/filter_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/service_providers_list_cubit/service_providers_list_cubit.dart';
import 'package:grad_project/patient/features/home/categories/widgets/service_provider_view_body.dart';

class ServiceProviderView extends StatelessWidget {
  const ServiceProviderView({super.key, required this.cName});
  final String cName;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(_)=> FilterCubit()),
        BlocProvider(create: (context)=>ServiceProvidersListCubit(repo:getIt<CategoriesRepo>()))
      ],
      child: Scaffold(
          appBar: AppBar(title: Text(cName, style: Styles.textStyle25.copyWith(
            color: AppTheme.mainContrast(context)
          ))),
          body: SafeArea(child: ServiceProviderViewBody(cName: cName,)),
        ),
    );
    
  }
}
