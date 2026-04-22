import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/reusable_dialog.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/map/location_services.dart';
import 'package:grad_project/patient/features/home/categories/data/create_request_model.dart';
import 'package:grad_project/patient/features/home/categories/view_model/create_request/create_request_cubit.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_action_button.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_text_field.dart';

class BookingBottomSheet extends StatefulWidget {
  final double screenWidth;
  final int serviceProviderId;

  const BookingBottomSheet({
    super.key,
    required this.screenWidth,
    required this.serviceProviderId,
  });

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  double? lat;
  double? long;
  bool isLocationLoading = false;
  String? _validationMessage;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
      initialTime: TimeOfDay.now(),
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
      setState(() {
        lat = locationData["lat"];
        long = locationData["long"];
      });
    } on LocationServiceException {
      _showErrorDialog(
        "خدمة الموقع مغلقة",
        "يجب تفعيل GPS على جهازك لتحديد الموقع.",
      );
    } on LocationPermissionException {
      _showErrorDialog(
        "صلاحية الموقع مرفوضة",
        "يجب السماح بالوصول للموقع.",
      );
    } catch (e) {
      _showErrorDialog("حدث خطأ", e.toString());
    } finally {
      if (mounted) setState(() => isLocationLoading = false);
    }
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => ReusableDialog(title: title, content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                "تفاصيل الحجز",
                style: TextStyle(
                  fontSize: (widget.screenWidth * 0.05).clamp(18, 22),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.mainContrast(context),
                  fontFamily: "Tajawal",
                ),
              ),
              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BookingTextField(
                      hint: "الاسم الأول",
                      controller: firstNameController,
                       onChanged: (_) {
                    // 👈
                    setState(() => _validationMessage = null); 
                  },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BookingTextField(
                      hint: "الاسم الأخير",
                      controller: lastNameController,
                       onChanged: (_) {
                    // 👈
                    setState(() => _validationMessage = null); 
                  },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              BookingTextField(
                hint: "وصف الحالة",
                maxLines: 3,
                controller: descriptionController,
                 onChanged: (_) {
                    // 👈
                    setState(() => _validationMessage = null); 
                  },
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: BookingSelectableBox(
                      hint: selectedTime == null
                          ? "الوقت"
                          : selectedTime!.format(context),
                      icon: Icons.access_time,
                      onTap: _pickTime,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: BookingSelectableBox(
                      hint: selectedDate == null
                          ? "التاريخ"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      icon: Icons.calendar_today_outlined,
                      onTap: _pickDate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              isLocationLoading
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : GestureDetector(
                      onTap: getLocation,
                      child: Icon(
                        lat != null
                            ? Icons.location_on
                            : Icons.location_on_outlined,
                        color: lat != null
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

              Row(
                children: [
                  Expanded(
                    child: BookingActionButton(
                      text: isLocationLoading
                          ? "جاري جلب الموقع..."
                          : "تأكيد الحجز",
                      color: isLocationLoading
                          ? Colors.grey
                          : const Color(0xff40B1D8),
                      textColor: Colors.white,
                      onTap: isLocationLoading
                          ? null
                          : () {
                              setState(() => _validationMessage = null);

                              if (formKey.currentState!.validate()) {
                                if (selectedDate == null ||
                                    selectedTime == null) {
                                  setState(() => _validationMessage =
                                      "يرجى اختيار التاريخ والوقت");
                                  return;
                                }

                                if (lat == null || long == null) {
                                  setState(() => _validationMessage =
                                      "يرجى تحديد موقعك أولاً");
                                  return;
                                }

                                final finalDateTime = DateTime(
                                  selectedDate!.year,
                                  selectedDate!.month,
                                  selectedDate!.day,
                                  selectedTime!.hour,
                                  selectedTime!.minute,
                                );

                                final requestModel = CreateRequestModel(
                                  serviceProviderId: widget.serviceProviderId,
                                  patientFirstName: firstNameController.text,
                                  patientLastName: lastNameController.text,
                                  description: descriptionController.text,
                                  scheduledDate: finalDateTime,
                                  latitude: lat!,
                                  longitude: long!,
                                );

                                context
                                    .read<CreateRequestCubit>()
                                    .createRequest(
                                      createRequestModel: requestModel,
                                    );
                                Navigator.pop(context);
                              }
                            },
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
            ],
          ),
        ),
      ),
    );
  }
}

class BookingSelectableBox extends StatelessWidget {
  final String hint;
  final IconData icon;
  final VoidCallback? onTap;

  const BookingSelectableBox({
    super.key,
    required this.hint,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppTheme.brandColor(context), width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hint,
              style: const TextStyle(
                color: Colors.grey,
                fontFamily: "Tajawal",
                fontSize: 12,
              ),
            ),
            Icon(icon, color: AppTheme.brandColor(context), size: 18),
          ],
        ),
      ),
    );
  }
}