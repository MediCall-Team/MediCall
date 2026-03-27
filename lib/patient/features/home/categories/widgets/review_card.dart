import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/categories/widgets/handle_stars_rate.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ReviewCard extends StatelessWidget {
  final dynamic review;
  final double screenWidth;

  const ReviewCard({
    super.key,
    required this.review,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // تعديل الصورة لتصبح مربعة مع حواف دائرية بسيطة
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(12), // تجعل المربع يبدو احترافياً
        //   child: Image.asset(
        //     review.image,
        //     width: size.width * 0.23, // عرض المربع
        //   //  height: size.width * 0.18, // طول المربع (ليكون متساوي)
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // ClipOval(
        //   child: 
      ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: CachedNetworkImage(
    imageUrl: review.image,
    width: size.width * 0.23,
    height: size.width * 0.18,
    fit: BoxFit.cover,
    errorWidget: (context, url, error) => Icon(Icons.error),
    placeholder: (context, url) => Shimmer(
      child: Container(
        width: size.width * 0.23,
        height: size.width * 0.18,
        color: Colors.grey,
      ),
    ),
  ),
),
       // ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      review.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: (size.width * 0.04).clamp(14, 35),
                        color: AppTheme.mainContrast(
                          context,
                        ), //const Color(0xff1F3E6C),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    review.createdAt,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: (size.width * 0.03).clamp(10, 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.25,
                    child: StarsRate(
                      rate: review.rate,
                      screenWidth: size.width,
                    ),
                  ),

                  Text(
                    "${review.rate}",
                    style: TextStyle(
                      color: AppTheme.mainContrast(
                        context,
                      ), //const Color(0xff1F3E6C),
                      fontWeight: FontWeight.bold,
                      fontSize: (size.width * 0.035).clamp(12, 30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                review.description,
                style: TextStyle(
                  color: const Color.fromARGB(235, 110, 101, 101),
                  fontSize: (size.width * 0.038).clamp(13, 30),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
