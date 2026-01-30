import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/features/home/categories/data/service_provider_profile_model.dart';

class ServireProviderProfileViewBody extends StatelessWidget {
  const ServireProviderProfileViewBody({super.key, required this.spModel});
  final ServiceProviderProfileModel spModel;
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [SliverToBoxAdapter(child: SPData(spModel: spModel,screenWidth: screenWidth,))],
    );
  }
}

class SPData extends StatelessWidget {
  const SPData({super.key, required this.spModel, required this.screenWidth});
  final ServiceProviderProfileModel spModel;
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        CircleAvatar(
        radius: (screenWidth*0.18).clamp(40, 140),//80,
          backgroundImage: AssetImage(spModel.doctorModel.image),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(spModel.doctorModel.name, style: Styles.textStyle25.copyWith(
            fontSize:(screenWidth*0.07).clamp(20, 40)
          )),
        ),
        Text(
          spModel.doctorModel.specialty,
          style: Styles.textStyle18w400.copyWith(color: kPrimaryColorE,
          fontSize: (screenWidth*0.045).clamp(16, 40)
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Wallet.png",
              ),
              SizedBox(width: 12,),
              Text("${spModel.doctorModel.price}جنيه",style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: (screenWidth*0.035).clamp(12, 30)
              ),),
            ],
          
          ),
        ),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: (screenWidth*0.07).clamp(16, 72),vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            CustomDetialCard(screenWidth: screenWidth,
              number: spModel.yearsofexperience,
           text: "سنوات الخبره"),
          
           CustomDetialCard(
            screenWidth: screenWidth,
            number: spModel.homeVisits,
           text: "زيارات منزليه"),
          
            CustomDetialCard(
              screenWidth: screenWidth,
              number: spModel.doctorModel.rate,
           text: "تقييم المرضي"),
          
          ],),
        )
      ],
    );
  }
}

class CustomDetialCard extends StatelessWidget {
  const CustomDetialCard({super.key, required this.number, required this.text, required this.screenWidth});
   final String number,text;
     final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffF8F8F8),
        boxShadow: const[
          BoxShadow(
             color: Colors.black26, // لون الشادو
            blurRadius: 8,         // درجة التمويه
            spreadRadius: 0.0,       // مدى انتشار الشادو
            offset: Offset(0, 4),
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          children: [
             Text(number,style: Styles.textStyle20.copyWith(
              fontSize: (screenWidth*0.045).clamp(16, 40)
             ),),
              Text(text , style: TextStyle(color: kPrimaryColorE,
              fontSize: (screenWidth*0.035).clamp(12, 40)
              ),),
          ],
        ),
      ),
    );
  }
}
