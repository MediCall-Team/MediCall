import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/presentation/views/mobile_home_view.dart';
import 'package:grad_project/patient/features/home/presentation/views/tablet_home_view.dart';
import 'package:grad_project/patient/features/home/categories/view_model/service_providers_list_cubit/service_providers_list_cubit.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => ServiceProvidersListCubit(
        repo:getIt<CategoriesRepo>()
      ),
      child: screenWidth > 550
          ? const TabletHomeView()
          : MobileHomeView(),
    );
  }
}