import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/features/home/models/doctor_model.dart';

class CustomDoctorCard extends StatelessWidget {
  const CustomDoctorCard({
    super.key,
    required this.iconSize,
    required this.doctorModel,
    required this.fontSize,
  });
  final double iconSize;
  final DoctorModel doctorModel;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: GestureDetector(
        onTap: () {
          // إضافة navigation هنا
        },
        child: Container(
          height: 250,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),

            // Border رمادي خفيف
            border: Border.all(color: Colors.grey.shade200, width: 1.4),

            // Shadow ناعم
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 12,
                spreadRadius: 0,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              // الصورة مع دائرة ملونة خلفها
              Stack(
                alignment: Alignment.center,
                children: [
                  // دائرة خلف الصورة للتأثير
                  Container(
                    width: (iconSize + 20) * 2,
                    height: (iconSize + 20) * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xffE8F7FC).withOpacity(0.5),
                    ),
                  ),
                  // صورة الدكتور
                  CircleAvatar(
                    radius: iconSize + 10,
                    backgroundImage: AssetImage(doctorModel.image),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // اسم الدكتور
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  doctorModel.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secColor,
                    fontFamily: "Tajawal",
                    fontSize: fontSize + 6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 8),

              // التخصص
              Text(
                doctorModel.specialty,
                style: TextStyle(
                  fontFamily: "Tajawal",
                  fontSize: fontSize - 2,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              // التقييم
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  // color: const Color(0xffFFF8E1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Color(0xffFFD33C), size: 30),
                    const SizedBox(width: 5),
                    Text(
                      doctorModel.rate,
                      style: TextStyle(
                        fontSize: fontSize - 1,
                        color: kPrimaryColorC,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}