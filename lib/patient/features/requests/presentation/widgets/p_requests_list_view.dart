import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/patient/features/requests/presentation/view_model/p_get_requests_cubit/p_get_requests_cubit.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/p_reqquest_item.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/requests_filter_bar.dart';

class PRequestsListView extends StatefulWidget {
  const PRequestsListView({super.key});

  @override
  State<PRequestsListView> createState() => _PRequestsListViewState();
}

class _PRequestsListViewState extends State<PRequestsListView> {
  late final ScrollController _scrollController;
  int? selectedStatus;

  @override
  void initState() {
    super.initState();
    
    _scrollController = ScrollController();
    
    // تحميل البيانات بعد ما الصفحة تتبنى
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final cubit = context.read<PGetRequestsCubit>();
        cubit.initPagination();
        cubit.loadFirstPage();
      }
    });
    
    // إضافة المستمع
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // أهم حاجة: نتأكد إن الصفحة لسه موجودة
    if (!mounted) return;
    
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      final cubit = context.read<PGetRequestsCubit>();
      cubit.loadMore();
    }
  }

  @override
  void dispose() {
    // إزالة المستمع قبل ما نمسح الـ controller
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
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
            
            final cubit = context.read<PGetRequestsCubit>();
            cubit.status = status;
            cubit.loadFirstPage();
          },
        ),
        Expanded(
          child: BlocBuilder<PGetRequestsCubit, PGetRequestsState>(
            builder: (context, state) {
              if (state is PGetRequestsLoading ) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (state is PGetRequestsFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errmsg),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<PGetRequestsCubit>().loadFirstPage();
                        },
                        child: const Text("حاول مرة تانية"),
                      ),
                    ],
                  ),
                );
              }
              
              if (state is PGetRequestsSuccess) {
                if (state.requests.isEmpty) {
                  return const Center(
                    child: Text("لا يوجد طلبات"),
                  );
                }
                
                return ListView.builder(
                  controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: state.requests.length + (state.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.requests.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    
                    return PRequestItem(
                      requestmodel: state.requests[index],
                    );
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