import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/cancel_reqest_cubit/cancel_request_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/update_request_cubit/update_request_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/p_get_requests_cubit/p_get_requests_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/p_requests_list_view.dart';

class RequestsViewBody extends StatelessWidget {
  const RequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// listener لتعديل الطلب
        BlocListener<UpdateRequestCubit, UpdateRequestState>(
          listener: (context, state) {
            if (state is UpdateRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("تم تعديل الطلب بنجاح")),
              );
              context.read<PGetRequestsCubit>().loadFirstPage();
            }
            if (state is UpdateRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMsg)),
              );
            }
          },
        ),
        
        /// listener لإلغاء الطلب
        BlocListener<CancelRequestCubit, CancelRequestState>(
          listener: (context, state) {
            if (state is CancelRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم إلغاء الطلب بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );
              context.read<PGetRequestsCubit>().loadFirstPage();
            }
            if (state is CancelRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errormsg),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: const PRequestsListView(),
    );
  }
}