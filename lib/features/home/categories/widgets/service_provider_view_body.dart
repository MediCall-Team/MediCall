import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:grad_project/constants.dart';

import 'package:grad_project/features/home/models/doctor_model.dart';

import 'package:grad_project/features/home/categories/widgets/service_provider_item.dart';

class ServiceProviderViewBody extends StatelessWidget {
  const ServiceProviderViewBody({super.key});

  static List<DoctorModel> doctorModelList = [
    DoctorModel(
      image: "assets/images/tempphoto.png",
      name: "حمزة طارق",
      specialty: "استشاري جراحة",
      rate: "4",
      price: "120",
      isActive: true
    ),
    DoctorModel(
      image: "assets/images/tempphoto.png",
      name: "حمزة طارق",
      specialty: "استشاري جراحة",
      rate: "4",
      price: "120",
      isActive: false
    ),
    DoctorModel(
      image: "assets/images/tempphoto.png",
      name: "حمزة طارق",
      specialty: "استشاري جراحة",
      rate: "4",
      price: "120",
      isActive: true
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

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
                      hintStyle: TextStyle(fontFamily: "Tajawal"),
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(Icons.search),
                      border: buildBorder(),
                      enabledBorder: buildBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 15),


                GestureDetector(
                  onTap: (){

                  },
                  
                  child: SvgPicture.asset("assets/images/align-left.svg")),


              ],
            ),
          ),

         Expanded(
           child: ListView.builder(
            itemCount: doctorModelList.length,
            itemBuilder: (context,index){
             return Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 5),
                   child: ServiceProviderItem(doctorModel: doctorModelList[index], screenWidth: screenWidth),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
                   child:index+1<doctorModelList.length? Divider():SizedBox(),
                 )
               ],
             );
           }),
         )
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
