import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/time_request_section.dart';
import 'package:grad_project/service_provider/features/requests/data/model/requests_model.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/create_report/create_report_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/get_requests_cubit/get_requests_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/request_management/request_management_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/report_dialog.dart';
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
  bool _isLoading = false; // إضافة حالة التحميل

  final timeFormat = DateFormat('hh:mm a', 'en');
  final dateFormat = DateFormat('dd / MM / yyyy', 'en');

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
    final request = widget.request;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<RequestManagementCubit, RequestManagementState>(
      listener: (context, state) {
        // عند بدء التحميل لنفس الـ request
        if (state is RequestManagementLoading &&
            state.requestId == request.requestId) {
          setState(() {
            _isLoading = true;
          });
        }

        // عند انتهاء التحميل (نجاح أو فشل)
        if ((state is RequestManagementSuccess &&
                state.requestId == request.requestId) ||
            (state is RequestManagementFailure &&
                state.requestId == request.requestId)) {
          setState(() {
            _isLoading = false;
          });

          // إذا كان نجاح، قم بإزالة الطلب
          if (state is RequestManagementSuccess) {
            context.read<GetRequestsCubit>().removeRequest(request.requestId);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم تنفيذ العملية بنجاح")),
            );
          }

          // إذا كان فشل، أظهر رسالة الخطأ
          if (state is RequestManagementFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        }
      },
      child: GestureDetector(
        onTap: _isLoading
            ? null
            : () {
                // منع الضغط أثناء التحميل
                setState(() {
                  expanded = !expanded;
                });
              },
        child: Container(
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
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          padding: const EdgeInsets.all(14),
          child: _isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: kPrimaryColorB),
                      const SizedBox(height: 16),
                      Text(
                        "جاري معالجة الطلب...",
                        style: TextStyle(
                          color: AppTheme.mainContrast(context),
                          fontFamily: "Tajawal",
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
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
                              style: TextStyle(
                                color: AppTheme.mainContrast(context),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TimeRequestSection(
                              screenWidth: screenWidth,
                              time: timeFormat.format(request.appointmentDate),
                              date: dateFormat.format(request.appointmentDate),
                            ),
                            const SizedBox(height: 14),
                            GestureDetector(
                              onTap: () {
                                _openMap(request.latitude, request.longitude);
                              },
                              child: Center(
                                child: Lottie.asset(
                                  "assets/animation/Location Pin.json",
                                  width: 60,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            /// الأزرار
                            if (request.status == 1)
                              SButtonRow(
                                screenWidth: screenWidth,
                                requestId: request.requestId,
                              )
                           // في request_item.dart
else if (request.status == 2)
  Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SCustomRequestButton(
        onTap: () {
          final createReportCubit = context.read<CreateReportCubit>();
          final getRequestsCubit = context.read<GetRequestsCubit>();
          
          showDialog(
            context: context,
            builder: (dialogContext) => ReportDialog(
              screenWidth: screenWidth,
              requestId: request.requestId,
              createReportCubit: createReportCubit,
              onReportSuccess: () { // ✅ أضف هذا الـ callback
                getRequestsCubit.removeRequest(request.requestId);
              },
            ),
          );
        },
        screenWidth: screenWidth,
        text: "كتابة تقرير الحالة",
        icon: Icons.edit_document,
        color: kPrimaryColorB,
        textColor: Colors.white,
      ),
    ),
  )
                            else
                              const SizedBox(),
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
      ),
    );
  }
}
