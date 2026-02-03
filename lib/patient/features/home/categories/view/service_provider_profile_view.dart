import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_profile_model.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/patient/features/home/categories/widgets/servire_provider_profile_view_body.dart';
import 'package:grad_project/patient/features/home/models/doctor_model.dart';

class ServiceProviderProfileView extends StatelessWidget {
  ServiceProviderProfileView({super.key});

  final ServiceProviderProfileModel
  serviceProviderProfileModel = ServiceProviderProfileModel(
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
    bio: "استشاري جراحة عظام متخصص في تشخيص وعلاج إصابات العظام والمفاصل، ويملك خبرة واسعة في التعامل مع حالات الكسور وآلام المفاصل المختلفة، مع الحرص على تقديم رعاية طبية دقيقة وآمنة للمرضى في منازلهم.",
    places: ["أخميم", "جرجا", "المراغه", "طهطا", "المنشأة", "ساقلته"],
    spReviews: ServiceProviderReviewsModel(
      rate: 4.5,
      numPepoleRate: 128,
      rateFive: 100,
      rateFour: 28,
      rateThree: 0,
      rateTwo: 0,
      rateOne: 0,
      reviewsList: [
        ReviewsModel(
          image: "assets/images/tempphoto.png",
          name: "ادهم محمد",
          description:
              "دكتور محترم جدًا وشرح الحالة بشكل واضح، والزيارة كانت في معادها بالظبط. حسّيت باهتمام ومتابعة كويسة بعد الكشف",
          rate: 4.5,
        ),
        ReviewsModel(
          image: "assets/images/tempphoto.png",
          name: "ادهم محمد",
          description:
              "دكتور محترم جدًا وشرح الحالة بشكل واضح، والزيارة كانت في معادها بالظبط. حسّيت باهتمام ومتابعة كويسة بعد الكشف",
          rate: 4.5,
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("بيانات الدكتور", style: Styles.textStyle25)),
      body: SafeArea(
        child: ServireProviderProfileViewBody(
          spModel: serviceProviderProfileModel,
        ),
      ),
    );
  }
}
