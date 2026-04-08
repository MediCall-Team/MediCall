import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/cancel_reqest_cubit/cancel_request_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/p_get_requests_cubit/p_get_requests_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/update_request_cubit/update_request_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/requests_view_body.dart';
import 'package:grad_project/patient/features/requests/repo/p_requests_repo.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PGetRequestsCubit(getIt<PRequestsRepo>()),
          ),
          BlocProvider(
            create: (context) => UpdateRequestCubit(getIt<PRequestsRepo>()),
          ),
          BlocProvider(
            create: (context) => CancelRequestCubit(getIt<PRequestsRepo>()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            //surfaceTintColor: Colors.transparent,
            title: Text(
              "الطلبات",
              style: Styles.textStyle25.copyWith(
                color: AppTheme.mainContrast(context),
              ),
            ),
          ),
          body: SafeArea(child: RequestsViewBody()),
        ),
      ),
    );
  }
}
