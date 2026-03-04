import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/widgets/stagged_step_animation.dart';

class AboutServiceProviderView extends StatelessWidget {
  const AboutServiceProviderView({super.key, required this.bio});
  final String bio;
  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          StaggeredStepAnimation(
            index: 0,
            child: Text("معلومات عن الدكتور ",style: Styles.textStyle20.copyWith(
              fontSize: (screenWidth*0.04).clamp(18, 40)
            ),),
          ),

          SizedBox(height: 12,),

          StaggeredStepAnimation(
            index: 1,
            child: Text(bio
            ,style: TextStyle(
              fontWeight: FontWeight.w500,
              color: kPrimaryColorE,
              fontSize:(screenWidth*0.03).clamp(16, 30)
            ),
            ),
          )
      
        ],
      ),
    );
  }
}