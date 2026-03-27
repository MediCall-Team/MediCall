import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/MedicalRecordItem.dart';

class MedicalRecordView extends StatelessWidget {
  const MedicalRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
      //  backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
        //  backgroundColor: Colors.white,
        //  iconTheme: const IconThemeData(color: Color(0xFF1F3E6C)),
          titleSpacing: 0,
          title:  Text(
            'سجل الحالة الطبية',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color:AppTheme.mainContrast(context) ,//Color(0xFF1F3E6C),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            MedicalRecordItem(
              date: '20 يناير 2026',
              doctorName: 'د. طارق محمد',
              specialty: 'استشاري أمراض القلب',
              imagePath: 'assets/images/tempphoto.png',
            ),
            SizedBox(height: 12),
            MedicalRecordItem(
              date: '20 يناير 2026',
              doctorName: 'د. محمد أحمد',
              specialty: 'استشاري أمراض القلب',
              imagePath: 'assets/images/tempphoto.png',
            ),
          ],
        ),
      ),
    );
  }
}
