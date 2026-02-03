import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class ReportDialog extends StatefulWidget {
  final double screenWidth;

  const ReportDialog({super.key, required this.screenWidth});

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final TextEditingController _reportController = TextEditingController();

  @override
  void dispose() {
    _reportController.dispose(); // تنظيف الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: Color(0xffE1F2F8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "إضافة تقرير طبي ",
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
            hintStyle: TextStyle(
              fontSize: (widget.screenWidth * 0.035).clamp(12, 16),
              color: Colors.grey,
            ),
            filled: true,
            fillColor: const Color(0xffF1F9FD).withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),

              borderSide: BorderSide(color: kPrimaryColorC),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // هنا نأخذ النص من الـ controller
              print("التقرير: ${_reportController.text}");
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text("حفظ", style: TextStyle(color: kPrimaryColorC)),
          ),

          SizedBox(width: 90),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: kPrimaryColorB,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
