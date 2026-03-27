import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_profile_model.dart';
import 'package:grad_project/patient/features/home/categories/widgets/custom_detail_card.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SPData extends StatelessWidget {
  const SPData({super.key, required this.spModel, required this.screenWidth});
  final ServiceProviderProfileModel spModel;
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),

        // CircleAvatar(
        //   radius: (screenWidth * 0.18).clamp(40, 140), //80,
        //   backgroundImage: AssetImage(spModel.doctorModel.image),
        // ),
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: spModel.doctorModel.image,
            width: (screenWidth * 0.18).clamp(40, 140),
            height: (screenWidth * 0.18).clamp(40, 140),
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),
            placeholder: (context, url) => Shimmer(
              // baseColor: Colors.grey.shade300,
              // highlightColor: Colors.grey.shade100,
              child: Container(
                width: (screenWidth * 0.18).clamp(40, 140),
                height: (screenWidth * 0.18).clamp(40, 140),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            spModel.doctorModel.name,
            style: Styles.textStyle25.copyWith(
              fontSize: (screenWidth * 0.07).clamp(20, 40),
              color: AppTheme.mainContrast(
                context,
              ), //  AppTheme.secondary(context)
            ),
          ),
        ),
        Text(
          spModel.doctorModel.specialty,
          style: Styles.textStyle18w400.copyWith(
            color: AppTheme.spStext(
              context,
            ), // AppTheme.textSecondary(context),
            fontSize: (screenWidth * 0.045).clamp(16, 40),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Wallet.png"),
              SizedBox(width: 12),
              Text(
                "${spModel.doctorModel.price}جنيه",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: (screenWidth * 0.035).clamp(12, 30),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (screenWidth * 0.07).clamp(16, 72),
            vertical: 18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomDetialCard(
              //   screenWidth: screenWidth,
              //  number: spModel.yearsofexperience,
              //   text: "سنوات الخبره",
              // ),
              CustomDetialCard(
                screenWidth: screenWidth,
                number: (spModel.homeVisits).toString(),
                text: "زيارات منزليه",
              ),
             SizedBox(width: 50,),
              CustomDetialCard(
                screenWidth: screenWidth,
                number: (spModel.doctorModel.rate).toString(),
                text: "تقييم المرضي",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
