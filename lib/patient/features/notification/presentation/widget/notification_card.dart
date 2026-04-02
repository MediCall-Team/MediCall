import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/app_theme.dart';
class NotificationCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final String time;
  final bool isRead; // استلام حالة القراءة مباشرة

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isRead = true, // افتراضيًا مقروء
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    double iconBoxSize = (screenWidth * 0.12).clamp(45, 60);
    double iconImageSize = iconBoxSize * 0.5;
    
    // الألوان بناءً على حالة القراءة
    final Color cardBg = isRead 
        ? AppTheme.spB(context) 
        : AppTheme.surfaceContainer(context);
    
    final Color dotColor = AppTheme.mainContrast(context); // لون النقطة للمنشور الجديد

    return Container(
      margin: const EdgeInsets.only(bottom: 16), // زيادة المسافة قليلًا
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20), // زوايا أنعم
        boxShadow: isRead ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ] : [], // إخفاء الظل في حالة غير المقروء لتمييزه باللون فقط
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack( // استخدام Stack لإضافة علامة "جديد"
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // حاوية الأيقونة
                  Container(
                    width: iconBoxSize,
                    height: iconBoxSize,
                    decoration: BoxDecoration(
                      color: isRead ? Colors.grey.shade50 : Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Image.asset(
                        icon,
                        width: iconImageSize,
                        height: iconImageSize,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: (screenWidth * 0.04).clamp(15, 17),
                                  fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                                  color: AppTheme.mainContrast(context),
                                  fontFamily: "Tajawal",
                                ),
                              ),
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                fontSize: 11,
                                color: isRead ? Colors.grey : dotColor,
                                fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: (screenWidth * 0.032).clamp(13, 15),
                            color: isRead ? Colors.grey.shade600 : Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // النقطة الزرقاء الصغيرة للإشعارات غير المقروءة
            if (!isRead)
              Positioned(
                top: 15,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}