import 'package:flutter/material.dart';
import 'package:grad_project/core/helper/reusable_shimmer.dart';
import 'package:grad_project/patient/features/home/categories/widgets/service_provider_item.dart';
import 'package:grad_project/patient/features/home/data/models/doctor_model.dart';

class ServiceProviderListSection extends StatelessWidget {
  const ServiceProviderListSection({
    super.key,
    required this.doctorModelList,
    required this.screenWidth,
    required this.screenHeight,
    required this.controller,
    required this.isLoadingMore,
  });

  final List<DoctorModel> doctorModelList;
  final double screenWidth;
  final double screenHeight;
  final ScrollController controller;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: doctorModelList.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < doctorModelList.length) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                child: ServiceProviderItem(
                  doctorModel: doctorModelList[index],
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: index + 1 < doctorModelList.length ? Divider() : SizedBox(),
              ),
            ],
          );
        } else {
          // shimmer loader
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ReusableShimmer()
          );
        }
      },
    );
  }
}