import 'package:flutter/material.dart';
import 'package:grad_project/features/notification/views/widget/notification_card.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Text(
                      'الإشعارات',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1F3E6C),
                      ),
                    ),

                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xff1F3E6C),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Text(
                  'اليوم',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                NotificationCard(
                  icon: 'assets/images/calendar2.png',
                  iconBg: const Color(0xffffffff),
                  title: 'تم تأكيد التعيين',
                  subtitle: 'تم تأكيد موعد زيارتك للطبيب',
                  time: 'منذ 5 ساعات',
                ),

                NotificationCard(
                  icon: 'assets/images/setting.png',
                  iconBg: const Color(0xffffffff),
                  title: 'تحديث النظام',
                  subtitle: 'تم إجراء تحديثات جديدة على النظام',
                  time: 'منذ 5 ساعات',
                ),

                NotificationCard(
                  icon: 'assets/images/scheduled.png',
                  iconBg: const Color(0xFFFFFFFF),
                  title: 'إعادة جدولة التعيين',
                  subtitle: 'تم تغيير موعد التعيين الخاص بك',
                  time: 'منذ 7 ساعات',
                ),

                NotificationCard(
                  icon: 'assets/images/reminder.png',
                  iconBg: const Color(0xffffffff),
                  title: 'تذكير بالمواعيد',
                  subtitle: 'لديك مواعيد اليوم',
                  time: 'منذ 9 ساعات',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
