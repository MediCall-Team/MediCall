import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/map/location_services.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_action_button.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_bottom_sheet.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_text_field.dart';
import 'package:grad_project/patient/features/requests/data/model/requests_model.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/update_request_cubit/update_request_cubit.dart';
import 'package:intl/intl.dart';

class UpdateRequestBottomSheet extends StatefulWidget {
  final double screenWidth;
  final PRequestData request;

  const UpdateRequestBottomSheet({
    super.key,
    required this.screenWidth,
    required this.request,
  });

  @override
  State<UpdateRequestBottomSheet> createState() =>
      _UpdateRequestBottomSheetState();
}

class _UpdateRequestBottomSheetState extends State<UpdateRequestBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final TextEditingController descriptionController = TextEditingController();

  double? lat;
  double? long;
  bool isLocationLoading = false;

  @override
  void initState() {
    super.initState();

    descriptionController.text = widget.request.description ?? '';

    // ✅ طريقة أكثر أماناً للتعامل مع التاريخ
    if (widget.request.date != null && widget.request.date.isNotEmpty) {
      try {
        // جرب عدة صيغ مختلفة
        String dateString = widget.request.date;

        // لو التاريخ بصيغة "2026-04-23"
        if (dateString.contains('-')) {
          final parts = dateString.split('-');
          if (parts.length == 3) {
            final year = int.parse(parts[0]);
            final month = int.parse(parts[1]);
            final day = int.parse(parts[2]);
            selectedDate = DateTime(year, month, day);
          }
        } else {
          // لو بصيغة تانية
          final dateFormat = DateFormat('yyyy-MM-dd');
          selectedDate = dateFormat.parse(dateString);
        }
      } catch (e) {
        print("Error parsing date: $e");
        selectedDate = null;
      }
    }

    // ✅ طريقة أكثر أماناً للوقت
    if (widget.request.time != null && widget.request.time.isNotEmpty) {
      try {
        String timeString = widget.request.time;

        // لو الوقت بصيغة "10:30 AM"
        final RegExp timeRegex = RegExp(
          r'(\d{1,2}):(\d{2})\s*(AM|PM)',
          caseSensitive: false,
        );
        final match = timeRegex.firstMatch(timeString);

        if (match != null) {
          int hour = int.parse(match.group(1)!);
          final minute = int.parse(match.group(2)!);
          final period = match.group(3)!.toUpperCase();

          if (period == 'PM' && hour != 12) {
            hour += 12;
          }
          if (period == 'AM' && hour == 12) {
            hour = 0;
          }

          selectedTime = TimeOfDay(hour: hour, minute: minute);
        }
      } catch (e) {
        print("Error parsing time: $e");
        selectedTime = null;
      }
    }

    lat = widget.request.latitude;
    long = widget.request.longitude;
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  Future<void> getLocation() async {
    setState(() => isLocationLoading = true);

    try {
      final locationData = await LocationService().getLocationData();

      if (mounted) {
        setState(() {
          lat = locationData["lat"];
          long = locationData["long"];
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("خطأ في تحديد الموقع")));
      }
    } finally {
      if (mounted) {
        setState(() => isLocationLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateRequestCubit, UpdateRequestState>(
      listener: (context, state) {
        if (state is UpdateRequestSuccess) {
          // إغلاق الـ bottom sheet
          Navigator.pop(context);
        }

        if (state is UpdateRequestFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer(context),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "تعديل الطلب",
                  style: TextStyle(
                    fontSize: (widget.screenWidth * 0.05).clamp(18, 22),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.mainContrast(context),
                    fontFamily: "Tajawal",
                  ),
                ),

                const SizedBox(height: 20),

                /// Description
                BookingTextField(
                  hint: "وصف الحالة",
                  maxLines: 3,
                  controller: descriptionController,
                ),

                const SizedBox(height: 15),

                /// Time + Date
                Row(
                  children: [
                    Expanded(
                      child: BookingSelectableBox(
                        hint: selectedTime == null
                            ? "الوقت"
                            : _formatTimeOfDay(selectedTime!),
                        icon: Icons.access_time,
                        onTap: _pickTime,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: BookingSelectableBox(
                        hint: selectedDate == null
                            ? "التاريخ"
                            : _formatDate(selectedDate!),
                        icon: Icons.calendar_today_outlined,
                        onTap: _pickDate,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Location
                isLocationLoading
                    ? const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : GestureDetector(
                        onTap: getLocation,
                        child: Icon(
                          lat != null && long != null
                              ? Icons.location_on
                              : Icons.location_on_outlined,
                          color: lat != null && long != null
                              ? Colors.green
                              : AppTheme.brandColor(context),
                          size: widget.screenWidth * 0.08,
                        ),
                      ),

                const SizedBox(height: 25),

                /// Buttons
                Row(
                  children: [
                    Expanded(
                      child: BookingActionButton(
                        text: "تحديث الطلب",
                        color: const Color(0xff40B1D8),
                        textColor: Colors.white,
                        onTap: _validateAndUpdate,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: BookingActionButton(
                        text: "إلغاء",
                        color: Colors.white,
                        textColor: const Color(0xff1F3E6C),
                        hasBorder: true,
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dt);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _validateAndUpdate() {
    // التحقق من صحة النموذج
    if (formKey.currentState!.validate()) {
      // التحقق من التاريخ
      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("يرجى اختيار التاريخ"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // التحقق من الوقت
      if (selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("يرجى اختيار الوقت"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // التحقق من الموقع
      if (lat == null || long == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("يرجى تحديد الموقع"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // دمج التاريخ والوقت
      final finalDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      // التحقق من أن التاريخ ليس في الماضي
      if (finalDateTime.isBefore(DateTime.now())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("لا يمكن اختيار تاريخ أو وقت في الماضي"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // استدعاء التحديث
      context.read<UpdateRequestCubit>().updateRequest(
        requestId: widget.request.id,
        scheduledDate: finalDateTime,
        latitude: lat!,
        longitude: long!,
        description: descriptionController.text,
      );
    }
  }
}
