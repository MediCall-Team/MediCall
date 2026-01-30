import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String time;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    // جلب أبعاد الشاشة
    final double screenWidth = MediaQuery.of(context).size.width;

    // حساب أحجام مرنة
    double iconBoxSize = (screenWidth * 0.12).clamp(40, 60);
    double iconImageSize = (iconBoxSize * 0.48);
    double titleSize = (screenWidth * 0.035).clamp(16, 18);
    double subtitleSize = (screenWidth * 0.03).clamp(12, 16);
    double timeSize = (screenWidth * 0.016).clamp(10, 12);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(screenWidth * 0.03).clamp(
        const EdgeInsets.all(8),
        const EdgeInsets.all(16),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06), // ظل أخف وأكثر عصرية
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // لضمان شكل احترافي إذا كان النص طويلاً
        children: [
          // حاوية الأيقونة المرنة
          Container(
            width: iconBoxSize,
            height: iconBoxSize,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade50), // إطار خفيف جداً
            ),
            child: Center(
              child: Image.asset(
                icon,
                width: iconImageSize,
                height: iconImageSize,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded( // لمنع تداخل النص مع الوقت
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F3E6C),
                          fontFamily: "Tajawal",
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: timeSize,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 6),
                
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: subtitleSize,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                    height: 1.3, // تباعد أسطر أفضل
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}