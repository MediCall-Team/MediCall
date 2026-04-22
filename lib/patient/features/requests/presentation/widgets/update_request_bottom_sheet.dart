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
  String? _validationMessage;

  @override
  void initState() {
    super.initState();

    descriptionController.text = widget.request.description ?? '';

    // مستمع لإخفاء رسالة الخطأ لما يبدأ الكتابة
    // descriptionController.addListener(() {
    //   if (_validationMessage != null && descriptionController.text.isNotEmpty) {
    //     setState(() => _validationMessage = null);
    //   }
    // });

    // parsing التاريخ
    if (widget.request.date != null && widget.request.date.isNotEmpty) {
      try {
        final dateString = widget.request.date;
        if (dateString.contains('-')) {
          final parts = dateString.split('-');
          if (parts.length == 3) {
            selectedDate = DateTime(
              int.parse(parts[0]),
              int.parse(parts[1]),
              int.parse(parts[2]),
            );
          }
        } else {
          selectedDate = DateFormat('yyyy-MM-dd').parse(dateString);
        }
      } catch (e) {
        selectedDate = null;
      }
    }

    // parsing الوقت
    if (widget.request.time != null && widget.request.time.isNotEmpty) {
      try {
        final timeString = widget.request.time;
        final match = RegExp(
          r'(\d{1,2}):(\d{2})\s*(AM|PM)',
          caseSensitive: false,
        ).firstMatch(timeString);

        if (match != null) {
          int hour = int.parse(match.group(1)!);
          final minute = int.parse(match.group(2)!);
          final period = match.group(3)!.toUpperCase();

          if (period == 'PM' && hour != 12) hour += 12;
          if (period == 'AM' && hour == 12) hour = 0;

          selectedTime = TimeOfDay(hour: hour, minute: minute);
        }
      } catch (e) {
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
      setState(() {
        selectedDate = picked;
        _validationMessage = null;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _validationMessage = null;
      });
    }
  }

  Future<void> getLocation() async {
    setState(() {
      isLocationLoading = true;
      _validationMessage = null;
    });

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
        setState(() => _validationMessage = "خطأ في تحديد الموقع");
      }
    } finally {
      if (mounted) setState(() => isLocationLoading = false);
    }
  }

  void _validateAndUpdate() {
    setState(() => _validationMessage = null);

    if (formKey.currentState!.validate()) {
      if (selectedDate == null || selectedTime == null) {
        setState(() => _validationMessage = "يرجى اختيار التاريخ والوقت");
        return;
      }

      if (lat == null || long == null) {
        setState(() => _validationMessage = "يرجى تحديد موقعك أولاً");
        return;
      }

      final finalDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      if (finalDateTime.isBefore(DateTime.now())) {
        setState(
          () => _validationMessage = "لا يمكن اختيار تاريخ أو وقت في الماضي",
        );
        return;
      }

      context.read<UpdateRequestCubit>().updateRequest(
        requestId: widget.request.id,
        scheduledDate: finalDateTime,
        latitude: lat!,
        longitude: long!,
        description: descriptionController.text,
      );
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dt);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateRequestCubit, UpdateRequestState>(
      listener: (context, state) {
        if (state is UpdateRequestSuccess) {
          Navigator.pop(context);
        }
        if (state is UpdateRequestFailure) {
          setState(() => _validationMessage = state.errorMsg);
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
                // العنوان
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
                // وفي الـ build غيري الـ BookingTextField لـ:
                BookingTextField(
                  hint: "وصف الحالة",
                  maxLines: 3,
                  controller: descriptionController,
                  onChanged: (_) {
                    // 👈
                    if (_validationMessage != null) {
                      setState(() => _validationMessage = null);
                    }
                  },
                ),
                const SizedBox(height: 15),

                // الوقت والتاريخ
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

                // الموقع
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
                const SizedBox(height: 20),

                // رسالة الخطأ الداخلية
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _validationMessage != null
                      ? Container(
                          key: ValueKey(_validationMessage),
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _validationMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: "Tajawal",
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // الأزرار
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
}
