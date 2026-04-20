import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:lottie/lottie.dart';

class AiViewBody extends StatelessWidget {
  const AiViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // استخراج أبعاد الشاشة لجعل التصميم مرن (Responsive)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        // استخدام نسبة من عرض الشاشة للحواف
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         //   SizedBox(height: screenHeight * 0.05), // مسافة علوية متغيرة

            // أيقونة الروبوت العلوية بتصميم متجاوب
            Center(
              child: Container(
                padding: const EdgeInsets.all(2), // للإطار الخارجي إذا أردت
               
                child: LottieBuilder.asset(
                  "assets/animation/eve.json",
                  width: screenWidth * 0.4, // حجم الأيقونة متناسب
                ),
              ),
            ),
            
            SizedBox(height: screenHeight * 0.04),

            // العنوان الرئيسي بتنسيق متجاوب
            Text(
              textAlign: TextAlign.end,
              "ادخل الاعراض لتحديد التخصص الطبي",
             // textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: (screenWidth * 0.05).clamp(16, 24), // حجم خط مرن بحدود
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A237E),
              ),
            ),
            
            const SizedBox(height: 20),

            // ملصق وصف الحالة
            const Text(
              textAlign: TextAlign.end,
              "وصف الحالة",
              style: TextStyle(
                fontSize: 14, 
                color: Colors.grey,
                fontFamily: "Poppins", // أو الخط المستخدم في مشروعك
              ),
            ),
            
            const SizedBox(height: 10),

          // حقل إدخال الأعراض المتمدد تلقائياً
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                // التعديل هنا:
                minLines: 4,     // يبدأ بـ 5 أسطر كحجم افتراضي
                maxLines: null,  // يسمح للحقل بالتمدد إلى ما لا نهاية حسب النص
                keyboardType: TextInputType.multiline, // لتحسين تجربة الكتابة متعددة الأسطر
                
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "اكتب الأعراض التي تشعر بها...",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(screenWidth * 0.04),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // زر "توقع التخصص" المتجاوب
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF42A5F5),
                      Color(0xFF1565C0),
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Action هنا
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        "توقع التخصص",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenWidth * 0.045).clamp(14, 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            // صندوق رسالة البوت المتجاوب
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
            //    border: Border.all(color: Colors.red.shade100, width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "عفواً، هذا الوصف غير كاف لأتمكن من مساعدتك. هل يمكنك وصف الأعراض التي تشعر بها بشكل أكثر دقة؟ (مثلاً: مكان الألم، متى بدأ، وهل هناك أعراض أخرى؟)",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: (screenWidth * 0.035).clamp(12, 15),
                            color: const Color(0xFF455A64),
                            height: 1.5,
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "١٠:٣١ ص",
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}