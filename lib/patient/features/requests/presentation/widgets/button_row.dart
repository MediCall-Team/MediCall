import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/patient/features/requests/data/model/requests_model.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/cancel_reqest_cubit/cancel_request_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/update_request_cubit/update_request_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/p_get_requests_cubit/p_get_requests_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/custom_request_button.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/update_request_bottom_sheet.dart';

class ButtonRow extends StatelessWidget {
  final double screenWidth;
  final PRequestData request;

  const ButtonRow({
    super.key,
    required this.screenWidth,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 1, child: SizedBox()),

        /// زر إلغاء الطلب
        GestureDetector(
          onTap: () => _showCancelDialog(context),
          child: CustomRequestButton(
            screenWidth: screenWidth,
            text: "الغاء الطلب",
            icon: "assets/images/trash.svg",
            color: Colors.white,
            textColor: kPrimaryColorC,
          ),
        ),

        const Expanded(flex: 3, child: SizedBox()),

        /// زر تعديل الطلب
        GestureDetector(
          onTap: () {
            _showUpdateBottomSheet(context);
          },
          child: CustomRequestButton(
            screenWidth: screenWidth,
            text: "تعديل الطلب",
            icon: "assets/images/pin.svg",
            color: kPrimaryColorB,
            textColor: Colors.white,
          ),
        ),

        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }

  void _showUpdateBottomSheet(BuildContext context) {
    Future.microtask(() {
      if (!context.mounted) return;
      
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (sheetContext) {
          return BlocProvider.value(
            value: context.read<UpdateRequestCubit>(),
            child: UpdateRequestBottomSheet(
              screenWidth: screenWidth,
              request: request,
            ),
          );
        },
      );
    });
  }

  void _showCancelDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // أيقونة تحذير
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: kPrimaryColorB,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),

            // العنوان
            const Text(
              "تأكيد الإلغاء",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Tajawal",
                color: Color(0xff1F3E6C),
              ),
            ),
            const SizedBox(height: 8),

            // المحتوى
            const Text(
              "هل أنت متأكد من إلغاء هذا الطلب؟",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Tajawal",
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // الأزرار
            Row(
              children: [
                // زر لا
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(
                        color: Color(0xff1F3E6C),
                        width: 0.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "لا",
                      style: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 14,
                        color: Color(0xff1F3E6C),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // زر نعم
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      _cancelRequest(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColorB,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "نعم، إلغاء",
                      style: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
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
 void _cancelRequest(BuildContext context) {
  context.read<CancelRequestCubit>().acceptRequest(request.id);
}

}