import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/patient/features/home/categories/view_model/create_request/create_request_cubit.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_bottom_sheet.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({super.key, required this.screenWidth, required this.id,required this.createRequestCubit});
  final double screenWidth;
  final int id;
  final CreateRequestCubit createRequestCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => BlocProvider.value(
                value: createRequestCubit,
                child: BookingBottomSheet(
                  screenWidth: screenWidth,
                  serviceProviderId: id, // تمرير المعرف هنا
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff40B1D8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "احجز الان",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:grad_project/patient/features/home/categories/widgets/booking_bottom_sheet.dart';

// class BookingButton extends StatelessWidget {
//   const BookingButton({super.key, required this.screenWidth, required this.id});
//   final double screenWidth;
//   final int id;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 22.0),
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           onPressed: () {
//           showModalBottomSheet(
//           context: context,
//           backgroundColor: Colors.transparent,
//           isScrollControlled: true,
//            builder:(context)=> BookingBottomSheet(screenWidth: screenWidth));

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
//               "احجز الان",
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