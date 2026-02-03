import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/profile/views/Sick%20record%20file.dart';

class MedicalRecordItem extends StatelessWidget {
  final String date;
  final String doctorName;
  final String specialty;
  final String imagePath;

  const MedicalRecordItem({
    super.key,
    required this.date,
    required this.doctorName,
    required this.specialty,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MedicalRecordDetails()),
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 24, backgroundImage: AssetImage(imagePath)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الطبيب المعالج :',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9C9C9C),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1F3E6C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      specialty,
                      style: const TextStyle(
                        color: Color(0xFF1F3E6C),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Color(0xFF9C9C9C),
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
