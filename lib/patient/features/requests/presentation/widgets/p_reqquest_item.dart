import 'package:flutter/material.dart';

import 'package:grad_project/constants.dart';

import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/requests/data/model/requests_model.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/button_row.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/time_request_section.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class PRequestItem extends StatefulWidget {
  PRequestItem({super.key, required this.requestmodel});

  final PRequestData requestmodel;

  @override
  State<PRequestItem> createState() => _PRequestItemState();
}

class _PRequestItemState extends State<PRequestItem> {
  final timeFormat = DateFormat('hh:mm a', 'ar');

  final dateFormat = DateFormat('dd / MM / yyyy', 'ar');

  Future<void> _openMap(double latitude, double longitude) async {
    final String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final Uri url = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("تعذر فتح الخريطة")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.spB(context),
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
                radius: (screenWidth * 0.05).clamp(30, 60),
                backgroundColor: kPrimaryColorB.withValues(alpha: 0.20),
                backgroundImage: NetworkImage(
                  widget.requestmodel.providerPictureUrl,
                ),
              ),

              const SizedBox(width: 6),

              Flexible(
                child: Text(
                  widget.requestmodel.providerName,
                  style: TextStyle(
                    color: AppTheme.mainContrast(context),
                    fontWeight: FontWeight.bold,
                    fontSize: (screenWidth * 0.035).clamp(12, 25),
                    fontFamily: "Tajawal",
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(width: 16),

              Container(
                decoration: BoxDecoration(
                  color: AppTheme.opacityAccent(context),
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Text(
                  widget.requestmodel.statusName,
                  style: TextStyle(
                    color: AppTheme.mainContrast(context),
                    fontWeight: FontWeight.w600,
                    fontSize: (screenWidth * 0.03).clamp(12, 24),
                    fontFamily: "Tajawal",
                  ),
                ),
              ),
            ],
          ),

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),

                  Text(
                    "وصف الحاله :",
                    style: TextStyle(
                      color: AppTheme.mainContrast(context),
                      fontWeight: FontWeight.bold,
                      fontSize: (screenWidth * 0.03).clamp(12, 24),
                      fontFamily: "Tajawal",
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    widget.requestmodel.description,
                    style: TextStyle(
                      color: AppTheme.mainContrast(context),
                      fontSize: (screenWidth * 0.03).clamp(12, 24),
                      fontFamily: "Tajawal",
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "الوقت المناسب للكشف:",
                    style: TextStyle(
                      color: AppTheme.mainContrast(context),
                      fontWeight: FontWeight.bold,
                      fontSize: (screenWidth * 0.03).clamp(12, 24),
                      fontFamily: "Tajawal",
                    ),
                  ),

                  const SizedBox(height: 10),

                  TimeRequestSection(
                    screenWidth: screenWidth,
                    time: widget.requestmodel.time,
                    date: widget.requestmodel.date,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "الموقع:",
                    style: TextStyle(
                      color: AppTheme.mainContrast(context),
                      fontWeight: FontWeight.bold,
                      fontSize: (screenWidth * 0.03).clamp(12, 24),
                      fontFamily: "Tajawal",
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      _openMap(
                        widget.requestmodel.latitude,
                        widget.requestmodel.longitude,
                      );
                    },
                    child: Center(
                      child: Lottie.asset(
                        "assets/animation/Location Pin.json",
                        width: 60,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  if (widget.requestmodel.statusName == 'قيد المراجعة')
                    ButtonRow(
                      screenWidth: screenWidth,
                      request: widget.requestmodel,
                    ),

                 // const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
