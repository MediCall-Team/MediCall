import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/create_report/create_report_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/get_requests_cubit/get_requests_cubit.dart';

class ReportDialog extends StatefulWidget {
  final double screenWidth;
  final int requestId;
  final CreateReportCubit createReportCubit;
  

  const ReportDialog({
    super.key,
    required this.screenWidth,
    required this.requestId,
    required this.createReportCubit,
  });

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final TextEditingController _reportController = TextEditingController();

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateReportCubit, CreateReportState>(
      bloc: widget.createReportCubit,
      listener: (context, state) {
        if (state is CreateReportSuccess) {
          // إظهار رسالة النجاح
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("تم إرسال التقرير بنجاح"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          // إغلاق الـ Dialog أولاً
          Navigator.pop(context);

          // تأخير تحديث القائمة قليلاً بعد إغلاق الـ Dialog
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              // التحقق من وجود الـ context قبل التحديث
              final getRequestsCubit = context.read<GetRequestsCubit>();
              if (getRequestsCubit.state is GetRequestsSuccess) {
                getRequestsCubit.removeRequest(widget.requestId);
              }
            }
          });
        }

        if (state is CreateReportFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        bool loading = state is CreateReportLoading;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: const Color(0xffE1F2F8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              "إضافة تقرير طبي",
              style: TextStyle(
                fontFamily: "Tajawal",
                fontWeight: FontWeight.bold,
                color: kPrimaryColorC,
                fontSize: (widget.screenWidth * 0.045).clamp(16, 22),
              ),
            ),
            content: TextField(
              controller: _reportController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "اكتب وصفاً دقيقاً للحالة هنا...",
                filled: true,
                fillColor: const Color(0xffF1F9FD).withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () {
                        if (_reportController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("الرجاء كتابة التقرير الطبي"),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        widget.createReportCubit.acceptRequest(
                          widget.requestId,
                          _reportController.text.trim(),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        "حفظ",
                        style: TextStyle(color: kPrimaryColorC),
                      ),
              ),
              const SizedBox(width: 90),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColorB,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "إلغاء",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}