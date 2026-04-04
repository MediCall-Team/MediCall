// import 'package:flutter/material.dart';
// import 'package:grad_project/constants.dart';
// import 'package:grad_project/core/utils/app_theme.dart';
// import 'package:grad_project/patient/features/requests/data/model/request_model.dart';
// import 'package:grad_project/patient/features/requests/presentation/widgets/button_row.dart';
// import 'package:grad_project/patient/features/requests/presentation/widgets/time_request_section.dart';
// import 'package:grad_project/service_provider/features/requests/data/model/requests_model.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';

// class RequestsViewBody extends StatelessWidget {
//   const RequestsViewBody({super.key});

  
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       itemCount: requestList.length,
//       itemBuilder: (context, index) {
//         return RequestItem(requestmodel: requestList[index]);
//       },
//     );
//   }
// }

// class RequestItem extends StatelessWidget {
//   RequestItem({super.key,  required this.requestmodel});
//   RequestData requestmodel;
//   final timeFormat = DateFormat('hh:mm a', 'ar');
//   final dateFormat = DateFormat('dd / MM / yyyy', 'ar');
  
//   @override
//   Widget build(BuildContext context) {
//      final double screenWidth=MediaQuery.of(context).size.width;
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color:AppTheme.spB(context) ,//Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: ExpansionTile(
//           tilePadding: const EdgeInsets.symmetric(horizontal: 16),
//           childrenPadding: const EdgeInsets.only(bottom: 12),

    
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CircleAvatar(
//                 radius: (screenWidth*0.05).clamp(30, 60),
//                 backgroundColor: kPrimaryColorB.withValues(alpha: 0.20),
//                 child: Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: Image.asset(
//                     "assets/images/dcRequestP.png",
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 6),
//               Flexible(
//                 child: Text(
//                   requestmodel.dcName,
//                   style:  TextStyle(
//                     color:AppTheme.mainContrast(context) ,//kPrimaryColorC,
//                     fontWeight: FontWeight.bold,
//                     fontSize: (screenWidth*0.035).clamp(12, 25),
//                     fontFamily: "Tajawal",
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Container(
//                 decoration: BoxDecoration(
//                   color:AppTheme.opacityAccent(context) ,//const Color.fromARGB(31, 6, 20, 4),
//                   borderRadius: BorderRadius.circular(22),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                 child: Text(
//                   requestmodel.status,
//                   style:  TextStyle(
//                     color:AppTheme.mainContrast(context) ,//kPrimaryColorC,
//                     fontWeight: FontWeight.w600,
//                     fontSize: (screenWidth*0.03).clamp(12, 24),
//                     fontFamily: "Tajawal",
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           children: [
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 6),
//                   Text(
//                     "وصف الحاله :",
//                     style:  TextStyle(
//                       color:AppTheme.mainContrast(context), //kPrimaryColorC,
//                       fontWeight: FontWeight.bold,
//                       fontSize: (screenWidth*0.03).clamp(12, 24),
//                       fontFamily: "Tajawal",
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     requestmodel.description,
//                     style:  TextStyle(
//                       color: AppTheme.mainContrast(context), //kPrimaryColorC,
//                       fontSize: (screenWidth*0.03).clamp(12, 24),
//                       fontFamily: "Tajawal",
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     "الوقت المناسب للكشف:",
//                     style:  TextStyle(
//                       color: AppTheme.mainContrast(context), //kPrimaryColorC,
//                       fontWeight: FontWeight.bold,
//                       fontSize: (screenWidth*0.03).clamp(12, 24),
//                       fontFamily: "Tajawal",
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TimeRequestSection(
//                     screenWidth: screenWidth,
//                     timeFormat: timeFormat,
//                     requestmodel: requestmodel,
//                     dateFormat: dateFormat,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     "الموقع:",
//                     style:  TextStyle(
//                       color: AppTheme.mainContrast(context), //kPrimaryColorC,
//                       fontWeight: FontWeight.bold,
//                       fontSize: (screenWidth*0.03).clamp(12, 24),
//                       fontFamily: "Tajawal",
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: Center(
//                       child: Lottie.asset(
//                         "assets/animation/Location Pin.json",
                        
//                         width: (screenWidth*0.075).clamp(50, 90),
                        
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   ButtonRow(screenWidth: screenWidth,),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
