import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/patient/features/home/categories/widgets/filter_section.dart';
import 'package:grad_project/patient/features/home/categories/widgets/service_provider_list_section.dart';
import 'package:grad_project/patient/features/home/models/doctor_model.dart';

class ServiceProviderViewBody extends StatelessWidget {
  const ServiceProviderViewBody({super.key});

  static List<DoctorModel> doctorModelList = [
    DoctorModel(
      image: "assets/images/tempphoto.png",
      name: "حمزة طارق",
      specialty: "استشاري جراحة",
      rate: "4",
      price: "120",
      isActive: true,
    ),
    DoctorModel(
      image: "assets/images/tempphoto.png",
      name: "حمزة طارق",
      specialty: "استشاري جراحة",
      rate: "4",
      price: "120",
      isActive: false,
    ),
    DoctorModel(
      image: "assets/images/tempphoto.png",
      name: "حمزة طارق",
      specialty: "استشاري جراحة",
      rate: "4",
      price: "120",
      isActive: true,
    ),
  ];

  
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "ابحث",
                      hintStyle: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: (screenWidth * 0.03).clamp(16, 22),
                      ),
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(Icons.search),
                      border: buildBorder(),
                      enabledBorder: buildBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 15),

                GestureDetector(
                  onTap: () {
                        
                  },

                  child: SvgPicture.asset("assets/images/align-left.svg"),
                ),
              ],
            ),
          ),

          // filter
          FilterSection(screenHeight: screenHeight,
          filterList: ["انثي","جرجا"],
          ),
       

          ServiceProviderListSection(doctorModelList: doctorModelList,
           screenWidth: screenWidth,
            screenHeight: screenHeight),
        ],
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: kPrimaryColorC, width: 1.5),
    );
  }
}
