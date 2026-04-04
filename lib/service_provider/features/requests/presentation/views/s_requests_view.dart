import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/cubit/get_requests_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/s_requests_view_body.dart';
import 'package:grad_project/service_provider/features/requests/repos/requests_repo.dart';

class SRequestsView extends StatelessWidget {
  const SRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => GetRequestsCubit(getIt<RequestsRepo>()),
        child: Scaffold(
          appBar: AppBar(title: Text("الطلبات", style: Styles.textStyle25)),
          body: SafeArea(child: SRequestsViewBody()),
        ),
      ),
    );
  }
}
