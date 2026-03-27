import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/views/s_p_profile.dart';


class SPProfileSettings extends StatelessWidget {
 const SPProfileSettings({super.key});

  // final ServiceProviderProfileModel
  // serviceProviderProfileModel = ServiceProviderProfileModel(
  //   doctorModel: DoctorModel(
  //     id:0,
  //     image: "assets/images/tempphoto.png",
  //     name: "حمزه طارق",
  //     specialty: "استشاري جراحه عظام",
  //     rate: 4.5,
  //     price: 120,
  //   //  isActive: true,
  //   ),
  //   homeVisits: "300",
  //   yearsofexperience: "5",
  //   bio: "استشاري جراحة عظام متخصص في تشخيص وعلاج إصابات العظام والمفاصل، ويملك خبرة واسعة في التعامل مع حالات الكسور وآلام المفاصل المختلفة، مع الحرص على تقديم رعاية طبية دقيقة وآمنة للمرضى في منازلهم.",
  //   places: ["أخميم", "جرجا", "المراغه", "طهطا", "المنشأة", "ساقلته"],
  //   spReviews: ServiceProviderReviewsModel(
  //     rate: 4.5,
  //     numPepoleRate: 128,
  //     rateFive: 100,
  //     rateFour: 28,
  //     rateThree: 0,
  //     rateTwo: 0,
  //     rateOne: 0,
  //     reviewsList: [
  //       ReviewsModel(
  //         image: "assets/images/tempphoto.png",
  //         name: "ادهم محمد",
  //         description:
  //             "دكتور محترم جدًا وشرح الحالة بشكل واضح، والزيارة كانت في معادها بالظبط. حسّيت باهتمام ومتابعة كويسة بعد الكشف",
  //         rate: 4.5,
  //       ),
  //       ReviewsModel(
  //         image: "assets/images/tempphoto.png",
  //         name: "ادهم محمد",
  //         description:
  //             "دكتور محترم جدًا وشرح الحالة بشكل واضح، والزيارة كانت في معادها بالظبط. حسّيت باهتمام ومتابعة كويسة بعد الكشف",
  //         rate: 4.5,
  //       ),
  //     ],
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text("بيانات الدكتور", style: Styles.textStyle25),
     actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: (){ 
                GoRouter.of(context).push(AppRouter.kServiceProviderEditView);
                },
            ),
          ],
        ),
        body: SafeArea(
          child: SPProfile()
        ),
      ),
    );
  }
}
