import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/profile/data/report_model.dart';

class MedicalRecordDetails extends StatelessWidget {
  final ReportModel report;
  const MedicalRecordDetails({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الحالة الطبية')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // التاريخ
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${report.createdAt?.day} / ${report.createdAt?.month} / ${report.createdAt?.year}",
                  style: const TextStyle(color: Color(0xFF9C9C9C), fontSize: 12),
                ),
              ),
              const SizedBox(height: 12),
              // بيانات الدكتور
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(report.providerImage ?? ""),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('الطبيب المعالج:', style: TextStyle(color: Color(0xFF9C9C9C))),
                      Text(report.providerFullName, style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.brandColor(context))),
                      Text(report.providerSpecialization ?? "", style: TextStyle(color: AppTheme.brandColor(context))),
                    ],
                  ),
                ],
              ),
              const Divider(height: 40),
                     Text('المريض:', style: TextStyle(color: AppTheme.brandColor(context) )),
                      Text(report.patientFullName, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9C9C9C))),
              // وصف الحالة من السيرفر
              Text('وصف الحالة:', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.brandColor(context))),
              const SizedBox(height: 8),
              Text(
                report.description ?? "لا يوجد وصف متاح حالياً.",
                style: const TextStyle(fontSize: 14, height: 1.6, color: Color(0xFF9C9C9C)),
              ),
              // ... باقي الـ Static UI (Bullets)
            ],
          ),
        ),
      ),
    );
  }
}