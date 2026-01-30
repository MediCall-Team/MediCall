import 'package:flutter/material.dart';
import 'package:grad_project/features/notification/widget/notification_view_body.dart';


class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: NotificationViewBody()),
    );
  }
}