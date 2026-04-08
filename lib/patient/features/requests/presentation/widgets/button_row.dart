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
      builder: (dialogContext) => AlertDialog(
        title: const Text("تأكيد الإلغاء"),
        content: const Text("هل أنت متأكد من إلغاء هذا الطلب؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("لا"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext); // إغلاق الـ Dialog
              _cancelRequest(context);
            },
            child: const Text(
              "نعم",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

 void _cancelRequest(BuildContext context) {
  context.read<CancelRequestCubit>().acceptRequest(request.id);
}

}