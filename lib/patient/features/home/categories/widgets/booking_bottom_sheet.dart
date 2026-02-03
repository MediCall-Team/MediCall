import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_action_button.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_text_field.dart';


class BookingBottomSheet extends StatefulWidget {
  final double screenWidth;
  const BookingBottomSheet({super.key, required this.screenWidth});

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // دالة اختيار التاريخ
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // يمنع اختيار أي تاريخ قديم
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  // دالة اختيار الوقت
  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffE1F2F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "تفاصيل الحجز",
            style: TextStyle(
              fontSize: (widget.screenWidth * 0.05).clamp(18, 22),
              fontWeight: FontWeight.bold,
              color: const Color(0xff1F3E6C),
              fontFamily: "Tajawal",
            ),
          ),
          const SizedBox(height: 20),
          const BookingTextField(hint: "وصف الحالة", maxLines: 3),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: BookingSelectableBox(
                  hint: selectedTime == null ? "اختيار الوقت" : selectedTime!.format(context),
                  icon: Icons.access_time,
                  onTap: _pickTime,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: BookingSelectableBox(
                  hint: selectedDate == null ? "اختيار التاريخ" : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  icon: Icons.calendar_today_outlined,
                  onTap: _pickDate,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Icon(Icons.location_on, color: const Color(0xff1F3E6C), size: widget.screenWidth * 0.08),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: BookingActionButton(
                  text: "تأكيد الحجز",
                  color: const Color(0xff40B1D8),
                  textColor: Colors.white,
                  onTap: () {
                    if (selectedDate == null || selectedTime == null) {
                      // تنبيه المستخدم لاختيار البيانات
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("يرجى اختيار التاريخ والوقت أولاً")),
                      );
                    } else {
                      // تنفيذ الحجز
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
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xff1F3E6C), width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
            Text(hint, style: const TextStyle(color: Colors.grey, fontFamily: "Tajawal")),
              Icon(icon, color: const Color(0xff1F3E6C), size: 20),
          ],
        ),
      ),
    );
  }
}
