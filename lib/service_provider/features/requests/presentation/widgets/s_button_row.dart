import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/get_requests_cubit/get_requests_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/request_management/request_management_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/s_custom_request_button.dart';

class SButtonRow extends StatelessWidget {
  const SButtonRow({
    super.key,
    required this.screenWidth,
    required this.requestId,
  });

  final double screenWidth;
  final int requestId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestManagementCubit, RequestManagementState>(
      listener: (context, state) {
        if (state is RequestManagementSuccess) {
          context.read<GetRequestsCubit>().removeRequest(requestId);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم تنفيذ العملية بنجاح")),
          );
        }

        if (state is RequestManagementFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        bool isLoadingThisRequest =
            state is RequestManagementLoading && state.requestId == requestId;

        return Row(
          children: [
            const Expanded(flex: 1, child: SizedBox()),

            /// -------- Reject --------
            SCustomRequestButton(
              onTap: () {
                context.read<RequestManagementCubit>().rejectRequest(requestId);
              },
              screenWidth: screenWidth,
              text: "الغاء الطلب",
              icon: Icons.cancel_outlined,
              color: Colors.white,
              textColor: kPrimaryColorC,
            ),

            const Expanded(flex: 3, child: SizedBox()),

            /// -------- Accept --------
            SCustomRequestButton(
              onTap: () {
                context.read<RequestManagementCubit>().acceptRequest(requestId);
              },
              screenWidth: screenWidth,
              text: "تأكيد الطلب",
              icon: Icons.done,
              color: kPrimaryColorB,
              textColor: Colors.white,
            ),

            const Expanded(flex: 1, child: SizedBox()),
          ],
        );
      },
    );
  }
}
