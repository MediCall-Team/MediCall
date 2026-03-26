import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/notification/widget/notification_card.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isTablet = width > 500;

    double titleFontSize = (width * 0.06).clamp(20, 30);
    double sectionFontSize = (width * 0.05).clamp(18, 24);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04), // Padding مرن
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      'الإشعارات',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color:AppTheme.mainContrast(context) ,//const Color(0xff1F3E6C),
                      ),
                    ),
                    const Spacer(),
                    if (!isTablet)
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: const Color(0xff1F3E6C),
                          size: (width * 0.07).clamp(24, 32),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                  ],
                ),
              ),
            ),

            // 2. كلمة "اليوم"
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'اليوم',
                  style: TextStyle(
                    fontSize: sectionFontSize,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // 3. قائمة الإشعارات (ListView مرن)
            SliverList(
              delegate: SliverChildListDelegate([
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
