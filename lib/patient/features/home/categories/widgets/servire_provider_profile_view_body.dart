import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_profile_model.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_button.dart';
import 'package:grad_project/patient/features/home/categories/widgets/s_p_data.dart';
import 'package:grad_project/patient/features/home/categories/widgets/tabs_section.dart';

class ServireProviderProfileViewBody extends StatelessWidget {
  const ServireProviderProfileViewBody({super.key, required this.spModel});
  final ServiceProviderProfileModel spModel;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SPData(spModel: spModel, screenWidth: screenWidth),
        ),

        SliverToBoxAdapter(
          child: TabsSection(
            spModel: spModel,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // زر الحجز
              BookingButton(screenWidth: screenWidth),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
