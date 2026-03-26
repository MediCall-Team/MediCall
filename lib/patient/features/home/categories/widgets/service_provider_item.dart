import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/data/models/doctor_model.dart';
import 'package:grad_project/patient/features/home/categories/widgets/custom_book_button.dart';
import 'package:grad_project/patient/features/home/categories/widgets/handle_stars_rate.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ServiceProviderItem extends StatelessWidget {
  const ServiceProviderItem({
    super.key,
    required this.doctorModel,
    required this.screenWidth,
    required this.screenHeight,
  });
  final DoctorModel doctorModel;
  final double screenWidth;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    double rate = (doctorModel.rate).toDouble();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //photo
        Flexible(
          child: SizedBox(
            width: screenWidth * 0.2,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CachedNetworkImage(
                  imageUrl: doctorModel.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Shimmer(child: Container(color: Colors.grey)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //name
              Text(
                doctorModel.name,
                style: Styles.textStyle15F.copyWith(
                  fontSize: screenWidth * 0.03,
                  color: AppTheme.mainContrast(
                    context,
                  ), // AppTheme.secondary(context)
                ),
              ),

              //rate
              Row(
                children: [
                  Text(
                    (doctorModel.rate).toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.mainContrast(
                        context,
                      ), //AppTheme.secondary(context),
                    ),
                  ),
                  const SizedBox(width: 6),

                  StarsRate(rate: rate, screenWidth: screenWidth),
                ],
              ),

              //price
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.035,
                    child: Image.asset("assets/images/money.png"),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "سعر الكشف : ${doctorModel.price} جنيه",
                    style: TextStyle(fontSize: screenWidth * 0.03),
                  ),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kServiceProviderProfile);
            },
            child: CustomBookButton(
              screenWidth: screenWidth,
              //   isActive: doctorModel.isActive,
            ),
          ),
        ),
      ],
    );
  }
}
