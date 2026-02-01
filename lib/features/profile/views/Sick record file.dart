import 'package:flutter/material.dart';
import 'package:grad_project/features/profile/widgets/Bulleitem.dart';
import 'package:grad_project/features/profile/widgets/ShareButton.dart';

class MedicalRecordDetails extends StatelessWidget {
  const MedicalRecordDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Color(0xFF1F3E6C)),
          titleSpacing: 0,
          title: const Text(
            '  الحالة الطبية',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFF1F3E6C),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  '20 يناير 2026',
                  style: TextStyle(
                    color: Color(0xFF9C9C9C),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/images/tempphoto.png'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'الطبيب المعالج:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9C9C9C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'د. طارق محمد',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF1F3E6C),
                        ),
                      ),
                      Text(
                        'استشاري أمراض القلب',
                        style: TextStyle(
                          color: Color(0xFF1F3E6C),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(
                thickness: 2,
                color: Color(0xFF1F3E6C),
                indent: 40,
                endIndent: 40,
              ),
              const SizedBox(height: 16),
              const Text(
                'وصف الحالة:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1F3E6C),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'يعاني المريض من آلام شديدة في الصدر '
                'وضيق في التنفس، تم تشخيص الحالة '
                'كنوبة قلبية حادة وتم إجراء قسطرة '
                'قلبية عاجلة وتركيب دعامة في الشريان '
                'التاجي الأمامي الأيسر.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Color(0xFF9C9C9C),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'خطة العلاج والمتابعة:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1F3E6C),
                ),
              ),
              const SizedBox(height: 8),
              const BulletItem(text: 'مراقبة بالقسم المركزة لمدة 48 ساعة'),
              const BulletItem(text: 'تناول أدوية السيولة وضغط الدم'),
              const BulletItem(text: 'وصف نظام غذائي صحي'),
              const BulletItem(text: 'متابعة بعد أسبوعين'),
              const SizedBox(height: 32),
              ShareButton(
                onPressed: () {
                  // الأكشن عند الضغط
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
