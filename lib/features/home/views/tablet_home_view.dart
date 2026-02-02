import 'package:flutter/material.dart';
import 'package:grad_project/features/home/views/home_view_body.dart';
import 'package:grad_project/features/notification/views/notification_view.dart';


class TabletHomeView extends StatelessWidget {
  const TabletHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
           
            Expanded(
              flex: 1, // مساحة أصغر للإشعارات
              child: NotificationView(), // بدون Scaffold جواها
            ),
             Expanded(
              flex: 1, // مساحة أكبر لـ HomeViewBody
              child: HomeViewBody(), // بدون Scaffold جواها
            ),
          ],
        ),
      ),
    );
  }
}
