import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/create_report/create_report_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/get_requests_cubit/get_requests_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/request_management/request_management_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/s_requests_view_body.dart';
import 'package:grad_project/service_provider/features/requests/repos/requests_repo.dart';

class SRequestsView extends StatelessWidget {
  const SRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetRequestsCubit(
              getIt<RequestsRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => RequestManagementCubit(
              getIt<RequestsRepo>(),
            ),
          ),
            BlocProvider(
            create: (context) => CreateReportCubit(
              getIt<RequestsRepo>(),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "الطلبات",
              style: Styles.textStyle25,
            ),
          ),
          body: const SafeArea(
            child: SRequestsViewBody(),
          ),
        ),
      ),
    );
  }
}