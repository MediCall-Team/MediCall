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
    return LayoutBuilder(
      builder: (context, constraints) {
        return IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: constraints.maxWidth < 250 ? constraints.maxWidth : 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200, width: 1.4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// الصورة
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: (iconSize + 18) * 2,
                            height: (iconSize + 18) * 2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffE8F7FC).withOpacity(0.5),
                            ),
                          ),
                          CircleAvatar(
                            radius: iconSize + 8,
                            backgroundImage:
                                AssetImage(doctorModel.image),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      /// الاسم (Expanded عشان يوحد الطول)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                doctorModel.name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "Tajawal",
                                  fontSize: fontSize + 6,
                                  fontWeight: FontWeight.bold,
                                  color: secColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                doctorModel.specialty,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "Tajawal",
                                  fontSize: fontSize - 2,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// التقييم
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xffFFD33C),
                              size: 26,
                            ),
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
            ),
          ),
        );
      },
    );
  }
}
