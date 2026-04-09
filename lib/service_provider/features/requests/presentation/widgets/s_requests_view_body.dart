import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/service_provider/features/requests/presentation/view_model/get_requests_cubit/get_requests_cubit.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/request_item.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/requests_filter_bar.dart';

class SRequestsViewBody extends StatefulWidget {
  const SRequestsViewBody({super.key});

  @override
  State<SRequestsViewBody> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<SRequestsViewBody> {
  final ScrollController controller = ScrollController();
  int? selectedStatus;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<GetRequestsCubit>();
    cubit.loadFirstPage();

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        cubit.loadMore();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RequestsFilterBar(
          selectedStatus: selectedStatus,
          onFilterChanged: (status) {
            setState(() {
              selectedStatus = status;
            });

            final cubit = context.read<GetRequestsCubit>();
            cubit.status = status;
            cubit.loadFirstPage();
          },
        ),
        Expanded(
          child: BlocBuilder<GetRequestsCubit, GetRequestsState>(
            builder: (context, state) {
              if (state is GetRequestsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetRequestsFailure) {
                return Center(child: Text(state.errorMsg));
              }

              if (state is GetRequestsSuccess) {
                if (state.requests.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "لا توجد طلبات",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontFamily: "Tajawal",
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: controller,
                  itemCount:
                      state.requests.length + (state.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.requests.length) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return RequestItem(request: state.requests[index]);
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}