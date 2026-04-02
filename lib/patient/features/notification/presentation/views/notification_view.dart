import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/notification/presentation/view_model/notifications/notifications_cubit.dart';
import 'package:grad_project/patient/features/notification/presentation/widget/notification_view_body.dart';
import 'package:grad_project/patient/features/notification/repo/noti_repo.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(getIt<NotiRepo>()),
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(child: NotificationViewBody()),
      ),
    );
  }
}
