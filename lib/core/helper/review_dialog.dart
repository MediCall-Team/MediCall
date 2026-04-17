import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/app_theme.dart';

class ReviewDialog extends StatefulWidget {
  // الـ Callback Function اللي هتستخدميها بره عشان تنادي الـ API
  final Function(double rating, String comment) onSave;

  const ReviewDialog({super.key, required this.onSave});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double _currentRating = 0; 
  final TextEditingController _commentController = TextEditingController();
  bool _showError = false; 

  @override
  Widget build(BuildContext context) {
    // جلب عرض الشاشة عشان نتحكم في حجم النجوم ديناميكياً
    double screenWidth = MediaQuery.of(context).size.width;
    double starSize = (screenWidth * 0.08).clamp(20.0, 35.0);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppTheme.surfaceContainer(context),
      title: const Text(
        "إضافة تقييمك",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Tajawal", fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        // تحديد عرض محدد للـ Dialog عشان الـ Row ميهربش
        width: screenWidth * 0.8, 
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("ما هو تقييمك للخدمة؟", style: TextStyle(fontFamily: "Tajawal")),
              const SizedBox(height: 10),
              
              // صف النجوم المعدل ليكون Dynamic
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Flexible(
                    child: IconButton(
                      // تقليل الـ Padding عشان مياخدش مساحة عرض كبيرة
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(), 
                      onPressed: () {
                        setState(() {
                          _currentRating = index + 1.0;
                          _showError = false;
                        });
                      },
                      icon: Icon(
                        index < _currentRating ? Icons.star_rounded : Icons.star_outline_rounded,
                        color: index < _currentRating ? Colors.amber : Colors.grey,
                        size: starSize, // حجم ديناميكي
                      ),
                    ),
                  );
                }),
              ),
              
              if (_showError)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text("برجاء تحديد التقييم بالنجوم أولاً",
                      style: TextStyle(color: Colors.red, fontSize: 12, fontFamily: "Tajawal")),
                ),
              const SizedBox(height: 20),
              
              TextField(
                controller: _commentController,
                maxLines: 3,
                textAlign: TextAlign.right, // عشان يدعم العربي صح
                decoration: InputDecoration(
                  hintText: "اكتب رأيك هنا ...",
                  hintStyle:  TextStyle(fontSize: 13,color:AppTheme.brandColor(context) ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إلغاء", style: TextStyle(color: Colors.grey, fontFamily: "Tajawal")),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.mainContrast(context),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            if (_currentRating == 0) {
              setState(() => _showError = true);
            } else {
              // تنفيذ الـ Callback وإرسال البيانات للخارج
              widget.onSave(_currentRating, _commentController.text);
              Navigator.pop(context);
            }
          },
          child:  Text("حفظ", style: TextStyle(color: Colors.white, fontFamily: "Tajawal")),
        ),
      ],
    );
  }
}