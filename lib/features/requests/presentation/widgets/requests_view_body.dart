import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/features/requests/data/model/request_model.dart';
import 'package:grad_project/features/requests/presentation/widgets/button_row.dart';
import 'package:grad_project/features/requests/presentation/widgets/time_request_section.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class RequestsViewBody extends StatelessWidget {
  const RequestsViewBody({super.key});

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

  @override
  Widget build(BuildContext context) {
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
          tilePadding: const EdgeInsets.symmetric(horizontal: 12),
          childrenPadding: const EdgeInsets.only(bottom: 12),

    
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 35,
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
                  style: const TextStyle(
                    color: kPrimaryColorC,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Tajawal",
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(31, 6, 20, 4),
                  borderRadius: BorderRadius.circular(22),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  requestmodel.status,
                  style: const TextStyle(
                    color: kPrimaryColorC,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: "Tajawal",
                  ),
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
                    style: const TextStyle(
                      color: kPrimaryColorC,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Tajawal",
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    requestmodel.description,
                    style: const TextStyle(
                      color: kPrimaryColorC,
                      fontSize: 14,
                      fontFamily: "Tajawal",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "الوقت المناسب للكشف:",
                    style: const TextStyle(
                      color: kPrimaryColorC,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Tajawal",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TimeRequestSection(
                    timeFormat: timeFormat,
                    requestmodel: requestmodel,
                    dateFormat: dateFormat,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "الموقع:",
                    style: const TextStyle(
                      color: kPrimaryColorC,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Tajawal",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Lottie.asset(
                        "assets/animation/Location Pin.json",
                        width: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: ButtonsRow()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
