

import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/features/home/models/doctor_model.dart';
import 'package:grad_project/features/home/categories/widgets/custom_book_button.dart';
import 'package:grad_project/features/home/categories/widgets/handle_stars_rate.dart';

class ServiceProviderItem extends StatelessWidget {
  const ServiceProviderItem({
    super.key,
    required this.doctorModel,
    required this.screenWidth, required this.screenHeight,
  });
  final DoctorModel doctorModel;
  final double screenWidth;
   final double screenHeight;
  @override
  Widget build(BuildContext context) {
    double rate = double.parse(doctorModel.rate);
    

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        //photo
        Flexible(
          child: SizedBox(
            width: screenWidth * 0.23,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(doctorModel.image, fit: BoxFit.cover),
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
              Text(doctorModel.name, style: Styles.textStyle15F.copyWith(
                fontSize: screenWidth*0.03
              )),

//rate
              Row(
                children: [
                  Text(
                    doctorModel.rate,
                    style: TextStyle(
                      fontSize:screenWidth*0.03,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColorC,
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
                    width: screenWidth*0.035,
                    child: Image.asset("assets/images/money.png")),
                  SizedBox(width: 10),
                  Text("سعر الكشف : ${doctorModel.price} جنيه",
                  style: TextStyle(fontSize: screenWidth*0.03),
                  ),
                ],
              ),
            ],
          ),
        ),

        Expanded(child: CustomBookButton(screenWidth: screenWidth,
        isActive:doctorModel.isActive)),
      ],
    );
  }
}

