
import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/home/categories/widgets/service_provider_item.dart';
import 'package:grad_project/patient/features/home/data/models/doctor_model.dart';

class ServiceProviderListSection extends StatelessWidget {
  const ServiceProviderListSection({
    super.key,
    required this.doctorModelList,
    required this.screenWidth,
    required this.screenHeight,
  });

  final List<DoctorModel> doctorModelList;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: doctorModelList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5,
                ),
                child: ServiceProviderItem(
                  doctorModel: doctorModelList[index],
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: index + 1 < doctorModelList.length
                    ? Divider()
                    : SizedBox(),
              ),
            ],
          );
        },
      ),
    );
  }
}

