import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/patient/features/requests/data/model/request_model.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/time_request_section.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/s_button_row.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class SRequestsViewBody extends StatelessWidget {
  const SRequestsViewBody({super.key});

  static List<RequestModel> requestList = [
    RequestModel(
      id: "1",
      description:
          "يعاني المريض من صداع مستمر منذ 3 أيام مع دوخة خفيفة وإرهاق عام، ولا يوجد تاريخ مرضي مزمن.",
      status: "قيد المراجعه",
      dcName: "حمزه طارق",
      location: Location(lng: 26.479011610738215, lat: 31.802292782744328),
      createdAt: DateTime.now(),
      date: DateTime.now(),
    ),

   RequestModel(
      id: "2",
      description:
          "يعاني المريض من صداع مستمر منذ 3 أيام مع دوخة خفيفة وإرهاق عام، ولا يوجد تاريخ مرضي مزمن.",
      status: "قيد المراجعه",
      dcName: "حمزه طارق",
      location: Location(lng: 26.479011610738215, lat: 31.802292782744328),
      createdAt: DateTime.now(),
      date: DateTime.now(),
    ),

       RequestModel(
      id: "3",
      description:
          "يعاني المريض من صداع مستمر منذ 3 أيام مع دوخة خفيفة وإرهاق عام، ولا يوجد تاريخ مرضي مزمن.",
      status: "قيد المراجعه",
      dcName: "حمزه طارق",
      location: Location(lng: 26.479011610738215, lat: 31.802292782744328),
      createdAt: DateTime.now(),
      date: DateTime.now(),
    ),


  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: requestList.length,
      itemBuilder: (context, index) {
        return RequestItem(requestmodel: requestList[index]);
      },
    );
  }
}

class RequestItem extends StatelessWidget {
  RequestItem({super.key, required this.requestmodel});
  final RequestModel requestmodel;
  final timeFormat = DateFormat('hh:mm a', 'ar');
  final dateFormat = DateFormat('dd / MM / yyyy', 'ar');
  // هذا التنسيق سيعرض: 20 يناير 2026
final createdDateFormat = DateFormat('d MMMM yyyy', 'ar');


  @override
  Widget build(BuildContext context) {
     final double screenWidth=MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          childrenPadding: const EdgeInsets.only(bottom: 12),

    
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: (screenWidth*0.05).clamp(30, 60),
                backgroundColor: kPrimaryColorB.withValues(alpha: 0.20),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    "assets/images/dcRequestP.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  requestmodel.dcName,
                  style:  TextStyle(
                    color: kPrimaryColorC,
                    fontWeight: FontWeight.bold,
                    fontSize: (screenWidth*0.035).clamp(12, 25),
                    fontFamily: "Tajawal",
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),

              Text(
                createdDateFormat.format(requestmodel.createdAt),
                style:  TextStyle(
                  color: kPrimaryColorE,
                  fontWeight: FontWeight.w600,
                  fontSize: (screenWidth*0.03).clamp(12, 24),
                  fontFamily: "Tajawal",
                ),
              ),

            ],
          ),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    "وصف الحاله :",
                    style:  TextStyle(
                      color: kPrimaryColorC,
                      fontWeight: FontWeight.bold,
                      fontSize: (screenWidth*0.03).clamp(12, 24),
                      fontFamily: "Tajawal",
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    requestmodel.description,
                    style:  TextStyle(
                      color: kPrimaryColorC,
                      fontSize: (screenWidth*0.03).clamp(12, 24),
                      fontFamily: "Tajawal",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "الوقت المناسب للكشف:",
                    style:  TextStyle(
                      color: kPrimaryColorC,
                      fontWeight: FontWeight.bold,
                      fontSize: (screenWidth*0.03).clamp(12, 24),
                      fontFamily: "Tajawal",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TimeRequestSection(
                    screenWidth: screenWidth,
                    timeFormat: timeFormat,
                    requestmodel: requestmodel,
                    dateFormat: dateFormat,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "الموقع:",
                    style:  TextStyle(
                      color: kPrimaryColorC,
                      fontWeight: FontWeight.bold,
                      fontSize: (screenWidth*0.03).clamp(12, 24),
                      fontFamily: "Tajawal",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Lottie.asset(
                        "assets/animation/Location Pin.json",
                        width: (screenWidth*0.075).clamp(50, 90),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SButtonRow(screenWidth: screenWidth,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
