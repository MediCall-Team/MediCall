import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/features/home/categories/data/service_provider_profile_model.dart';
import 'package:grad_project/features/home/categories/widgets/servire_provider_profile_view_body.dart';
import 'package:grad_project/features/home/models/doctor_model.dart';

class ServiceProviderProfileView extends StatelessWidget {
  ServiceProviderProfileView({super.key});

  final ServiceProviderProfileModel serviceProviderProfileModel =
      ServiceProviderProfileModel(
        doctorModel: DoctorModel(
          image: "assets/images/tempphoto.png",
          name: "حمزه طارق",
          specialty: "استشاري جراحه عظام",
          rate: "4.5",
          price: "120",
          isActive: true,
        ),
        homeVisits: "300",
        yearsofexperience: "5",
        bio: "",
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("بيانات الدكتور",style: Styles.textStyle25,),),
      body: SafeArea(child: ServireProviderProfileViewBody(
spModel: serviceProviderProfileModel,

    )));
  }
}
