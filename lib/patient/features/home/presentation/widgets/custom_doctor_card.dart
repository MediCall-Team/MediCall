import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/data/models/doctor_model.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomDoctorCard extends StatelessWidget {
  const CustomDoctorCard({
    super.key,
    required this.iconSize,
    required this.doctorModel,
    required this.fontSize,
    required this.cardWidth, // أضفنا هذا المتغير
  });

  final double iconSize;
  final DoctorModel doctorModel;
  final double fontSize;
  final double cardWidth; // العرض النسبي

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth, // العرض الآن مرن
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.spB(context), //AppTheme.background(context),
        borderRadius: BorderRadius.circular(20), // يمكن جعلها نسبية أيضاً
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // نستخدم أبعاد الكارت نفسه لتنسيق المحتوى داخله
          double h = constraints.maxHeight;

          return Column(
            children: [
              SizedBox(height: h * 0.08), // مسافة علوية نسبية

              /// قسم الصورة - يعتمد على ارتفاع الكارت
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     Container(
              //       width: h * 0.35, // الدائرة 35% من ارتفاع الكارت
              //       height: h * 0.35,
              //       decoration: const BoxDecoration(
              //         shape: BoxShape.circle,
              //      //   color: Color(0xffE8F7FC),
              //       ),
              //     ),
              //     CircleAvatar(
              //       radius: h * 0.15, // الصورة داخل الدائرة بنسبة متناسقة
              //       backgroundImage: AssetImage(doctorModel.image),
              //       backgroundColor: Colors.transparent,
              //     ),
              //   ],
              // ),
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: doctorModel.image,
                  width: h.clamp(35, 80),
                  height: h.clamp(35, 80),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  placeholder: (context, url) => Shimmer(
                    // baseColor: Colors.grey.shade300,
                    // highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: h.clamp(35, 80),
                      height: h.clamp(35, 80),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.05),

              /// النصوص
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Text(
                      doctorModel.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: (h * 0.07).clamp(
                          14,
                          22,
                        ), // الخط يكبر مع الكارت
                        fontWeight: FontWeight.bold,
                        color: AppTheme.mainContrast(
                          context,
                        ), //AppTheme.textSecondaryTwo(context),//const Color(0xff2D3142),
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Text(
                      doctorModel.specialty,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: (h * 0.05).clamp(11, 16),
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              /// التقييم
              Container(
                margin: EdgeInsets.only(bottom: h * 0.08),
                padding: EdgeInsets.symmetric(
                  horizontal: cardWidth * 0.1,
                  vertical: h * 0.02,
                ),
                decoration: BoxDecoration(
                  // color: const Color(0xffFFF9E5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: const Color(0xffFFD33C),
                      size: h * 0.08,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      (doctorModel.rate).toString(),
                      style: TextStyle(
                        fontSize: (h * 0.06).clamp(12, 18),
                        fontWeight: FontWeight.bold,
                        // color: Colors.orange[800],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),
            ],
          );
        },
      ),
    );
  }
}
