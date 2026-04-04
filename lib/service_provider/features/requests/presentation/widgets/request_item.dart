import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/time_request_section.dart';
import 'package:grad_project/service_provider/features/requests/data/model/requests_model.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/report_dialog.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/request_status.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/s_button_row.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/s_custom_request_button.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestItem extends StatefulWidget {
  const RequestItem({super.key, required this.request});

  final RequestData request;

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  bool expanded = false;

  final timeFormat = DateFormat('hh:mm a', 'en');
  final dateFormat = DateFormat('dd / MM / yyyy', 'en');


  Future<void> _openMap(double latitude, double longitude) async {
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final Uri url = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      // يمكنك إظهار Snackbar في حالة وجود خطأ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تعذر فتح الخريطة")),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final request = widget.request;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.spB(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------------- HEADER ----------------
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(request.patientImage),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    "${request.patientFirstName} ${request.patientLastName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (screenWidth * 0.035).clamp(12, 22),
                      color: AppTheme.mainContrast(context),
                      fontFamily: "Tajawal",
                    ),
                  ),
                ),

                Text(
                  dateFormat.format(request.createdAt),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.mainContrast(context),
                  ),
                ),

                const SizedBox(width: 8),

                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ],
            ),

            /// ---------------- BODY ----------------
            AnimatedCrossFade(
              firstChild: const SizedBox(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// وصف الحالة
                    Text(
                      "وصف الحالة",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.mainContrast(context),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      request.description ?? "لا يوجد وصف",
                      style: TextStyle(color: AppTheme.mainContrast(context)),
                    ),

                    const SizedBox(height: 12),

                    /// التاريخ والوقت
                    TimeRequestSection(
                      dateFormat: dateFormat,
                      timeFormat: timeFormat,
                      requestmodel: request,
                      screenWidth: screenWidth,
                    ),

                    const SizedBox(height: 14),

                    /// الموقع
                    
                    GestureDetector(
                      onTap:(){
                        _openMap(request.latitude, request.longitude);
                      } ,
                      child: Center(
                        child: Lottie.asset(
                          "assets/animation/Location Pin.json",
                          width: 60,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// الأزرار
                    request.status == 1
                        ? SButtonRow(screenWidth: screenWidth)
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                              ),
                              child: SCustomRequestButton(
                                onTap: () {
                                  //
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        ReportDialog(screenWidth: screenWidth),
                                  );
                                },
                                screenWidth: screenWidth,
                                text: "كتابة تقرير الحالة",
                                icon: Icons
                                    .edit_document, //Icons.app_registration_rounded,
                                color: kPrimaryColorB,
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              crossFadeState: expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }
}
