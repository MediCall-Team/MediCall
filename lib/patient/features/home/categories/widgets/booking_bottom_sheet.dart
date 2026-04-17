import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/reusable_dialog.dart';
import 'package:grad_project/core/helper/snakbar.dart';
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
  bool isLocationLoading = false; // حالة تحميل الموقع

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
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  Future<void> getLocation() async {
    setState(() => isLocationLoading = true);
    try {
      final locationData = await LocationService().getLocationData();
      setState(() {
        lat = locationData["lat"];
        long = locationData["long"];
      });
      if (mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("تم تحديد موقعك بنجاح")),
        // );
      }
    } on LocationServiceException {
      _showErrorDialog("خدمة الموقع مغلقة", "يجب تفعيل GPS على جهازك لتحديد الموقع.");
    } on LocationPermissionException {
      _showErrorDialog("صلاحية الموقع مرفوضة", "يجب السماح بالوصول للموقع.");
    } catch (e) {
      _showErrorDialog("حدث خطأ", e.toString());
    } finally {
      if (mounted) setState(() => isLocationLoading = false);
    }
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => ReusableDialog(
        title: title,
        content: content,
      ),
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
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BookingTextField(
                      hint: "الاسم الأخير",
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              
              BookingTextField(
                hint: "وصف الحالة",
                maxLines: 3,
                controller: descriptionController,
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
              
              // مؤشر تحميل الموقع أو الأيقونة
              isLocationLoading 
                ? const SizedBox(
                    height: 30, 
                    width: 30, 
                    child: CircularProgressIndicator(strokeWidth: 2)
                  )
                : GestureDetector(
                    onTap: getLocation,
                    child: Icon(
                      lat != null ? Icons.location_on : Icons.location_on_outlined,
                      color: lat != null ? Colors.green : AppTheme.brandColor(context),
                      size: widget.screenWidth * 0.08,
                    ),
                  ),
              const SizedBox(height: 25),
              
              Row(
                children: [
                  Expanded(
                    child: BookingActionButton(
                      text: isLocationLoading ? "جاري جلب الموقع..." : "تأكيد الحجز",
                      color: isLocationLoading ? Colors.grey : const Color(0xff40B1D8),
                      textColor: Colors.white,
                      onTap: isLocationLoading ? null : () {
                        // 1. تشغيل الـ Validation للحقول النصية
                        if (formKey.currentState!.validate()) {
                          
                          // 2. التحقق من التاريخ والوقت والموقع يدوياً
                          if (selectedDate == null || selectedTime == null) {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text("يرجى اختيار التاريخ والوقت")),
                            // );
                            snackBarMethod(context, "يرجى اختيار التاريخ والوقت");
                            return;
                          }

                          if (lat == null || long == null) {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text("يرجى تحديد موقعك أولاً")),
                            // );
                            snackBarMethod(context, "يرجى تحديد موقعك أولاً");
                            return;
                          }

                          // 3. دمج التاريخ والوقت وتحويلهم لـ UTC
                          final finalDateTime = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedTime!.hour,
                            selectedTime!.minute,
                          );

                          // 4. إنشاء الموديل
                          final requestModel = CreateRequestModel(
                            serviceProviderId: widget.serviceProviderId,
                            patientFirstName: firstNameController.text,
                            patientLastName: lastNameController.text,
                            description: descriptionController.text,
                            scheduledDate: finalDateTime,
                            latitude: lat!,
                            longitude: long!,
                          );

                          // 5. إرسال للـ Cubit وغلق الـ Sheet
                          context.read<CreateRequestCubit>().createRequest(
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

  const BookingSelectableBox({super.key, required this.hint, required this.icon, this.onTap});

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
            Text(hint, style: const TextStyle(color: Colors.grey, fontFamily: "Tajawal", fontSize: 12)),
            Icon(icon, color: AppTheme.brandColor(context), size: 18),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:grad_project/constants.dart';
// import 'package:grad_project/core/helper/reusable_dialog.dart';
// import 'package:grad_project/core/utils/app_theme.dart';
// import 'package:grad_project/core/utils/map/location_services.dart';
// import 'package:grad_project/patient/features/home/categories/widgets/booking_action_button.dart';
// import 'package:grad_project/patient/features/home/categories/widgets/booking_text_field.dart';


// class BookingBottomSheet extends StatefulWidget {
//   final double screenWidth;
//   const BookingBottomSheet({super.key, required this.screenWidth});

//   @override
//   State<BookingBottomSheet> createState() => _BookingBottomSheetState();
// }

// class _BookingBottomSheetState extends State<BookingBottomSheet> {
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;


//   // دالة اختيار التاريخ
//   Future<void> _pickDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(), // يمنع اختيار أي تاريخ قديم
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );
//     if (picked != null) setState(() => selectedDate = picked);
//   }

//   // دالة اختيار الوقت
//   Future<void> _pickTime() async {
//     TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) setState(() => selectedTime = picked);
//   }


  
//   double? lat;
//   double? long;
//   GlobalKey<FormState> formKey = GlobalKey();

//   Future<void> getLocation() async {
//     try {
//       // جلب الموقع باستخدام LocationService
//       final locationData = await LocationService().getLocationData();

//       lat = locationData["lat"];
//       long = locationData["long"];

//       // تحديث الـ TextField بالعناوين
     

//     } on LocationServiceException {
//       // GPS مغلق
//     showDialog(
//   context: context,
//   builder: (context) => ReusableDialog(
//     title: "خدمة الموقع مغلقة",
//     content: "يجب تفعيل GPS على جهازك لتحديد الموقع.",
//   ),
// );
//     } on LocationPermissionException {
//       // صلاحية الموقع مرفوضة
//     showDialog(
//   context: context,
//   builder: (context) => ReusableDialog(
//     title: "صلاحية الموقع مرفوضة",
//     content:  "يجب السماح للتطبيق بالوصول إلى الموقع لتحديد موقعك.",
//   ),
// );


//     } catch (e) {
//   showDialog(
//   context: context,
//   builder: (context) => ReusableDialog(
//     title: "حدث خطأ",
//     content: e.toString(),
//   ),
// );
      
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         left: 20, right: 20, top: 20,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//       ),
//       decoration:  BoxDecoration(
//         color:AppTheme.surfaceContainer(context) ,//Color(0xffE1F2F8),
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "تفاصيل الحجز",
//             style: TextStyle(
//               fontSize: (widget.screenWidth * 0.05).clamp(18, 22),
//               fontWeight: FontWeight.bold,
//               color:AppTheme.mainContrast(context) ,//const Color(0xff1F3E6C),
//               fontFamily: "Tajawal",
//             ),
//           ),
//           const SizedBox(height: 20),
//           const BookingTextField(hint: "وصف الحالة", maxLines: 3),
//           const SizedBox(height: 15),
//           Row(
//             children: [
//               Expanded(
//                 child: BookingSelectableBox(
//                   hint: selectedTime == null ? "اختيار الوقت" : selectedTime!.format(context),
//                   icon: Icons.access_time,
//                   onTap: _pickTime,
//                 ),
//               ),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: BookingSelectableBox(
//                   hint: selectedDate == null ? "اختيار التاريخ" : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
//                   icon: Icons.calendar_today_outlined,
//                   onTap: _pickDate,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Icon(Icons.location_on, color:AppTheme.brandColor(context) ,// const Color(0xff1F3E6C),
//            size: widget.screenWidth * 0.08),
//           const SizedBox(height: 25),
//           Row(
//             children: [
//               Expanded(
//                 child: BookingActionButton(
//                   text: "تأكيد الحجز",
//                   color: const Color(0xff40B1D8),
//                   textColor: Colors.white,
//                   onTap: () {
//                     if (selectedDate == null || selectedTime == null) {
//                       // تنبيه المستخدم لاختيار البيانات
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("يرجى اختيار التاريخ والوقت أولاً")),
//                       );
//                     } else {
//                       // تنفيذ الحجز
//                     }
//                   },
//                 ),
//               ),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: BookingActionButton(
//                   text: "إلغاء",
//                   color: Colors.white,
//                   textColor: const Color(0xff1F3E6C),
//                   hasBorder: true,
//                   onTap: () => Navigator.pop(context),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BookingSelectableBox extends StatelessWidget {
//   final String hint;
//   final IconData icon;
//   final VoidCallback? onTap;

//   const BookingSelectableBox({super.key, required this.hint, required this.icon, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//          // color: Colors.white.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: AppTheme.brandColor(context), width: 0.8),
          
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
          
//             Text(hint, style: const TextStyle(color: Colors.grey, fontFamily: "Tajawal")),
//               Icon(icon, color:AppTheme.brandColor(context) ,//const Color(0xff1F3E6C), 
//               size: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
