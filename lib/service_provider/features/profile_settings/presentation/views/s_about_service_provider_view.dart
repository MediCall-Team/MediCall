// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:grad_project/constants.dart';
// import 'package:grad_project/core/utils/app_router.dart';
// import 'package:grad_project/core/utils/styles.dart';

// class SAboutServiceProviderView extends StatelessWidget {
//   const SAboutServiceProviderView({super.key, required this.bio});
//   final String bio;
//   @override
//   Widget build(BuildContext context) {
//      double screenWidth = MediaQuery.sizeOf(context).width;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
          
//           Text("معلومات عن الدكتور ",style: Styles.textStyle20.copyWith(
//             fontSize: (screenWidth*0.04).clamp(18, 40)
//           ),),
//           SizedBox(height: 12,),
//           Text(bio
//           ,style: TextStyle(
//             fontWeight: FontWeight.w500,
//             color: kPrimaryColorE,
//             fontSize:(screenWidth*0.03).clamp(16, 30)
//           ),
//           ),

//        SizedBox(height: 20,),
//        SEditButton(screenWidth: screenWidth),
      
//         ],
//       ),
//     );
//   }
// }



// class SEditButton extends StatelessWidget {
//   const SEditButton({super.key, required this.screenWidth});
//   final double screenWidth;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 22.0),
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           onPressed: () {
//         GoRouter.of(context).push(AppRouter.kServiceProviderEditView);

//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xff40B1D8),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child:  Text(
//               "تعديل",
//               style: TextStyle(
//                 fontSize:screenWidth*0.04, //20,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }