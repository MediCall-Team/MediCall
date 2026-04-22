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

class _PRequestsListViewState extends State<PRequestsListView>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  int? selectedStatus;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final cubit = context.read<PGetRequestsCubit>();
        cubit.initPagination();
        cubit.loadFirstPage();
      }
    });
  }

  void _onScroll() {
    if (!mounted) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final cubit = context.read<PGetRequestsCubit>();
      cubit.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _animationController.dispose();
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
              if (state is PGetRequestsLoading) {
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      _animationController.forward();
                    }
                  });

                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: const _EmptyRequestsWidget(),
                    ),
                  );
                }

                // إعادة الـ animation لو رجعت قائمة فيها بيانات
                _animationController.reset();

                return ListView.builder(
                  controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount:
                      state.requests.length + (state.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.requests.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
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

class _EmptyRequestsWidget extends StatelessWidget {
  const _EmptyRequestsWidget();

  @override
  Widget build(BuildContext context) {
    const color = Color(0xff40B1D8);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // دوائر متداخلة مع أيقونة
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.08),
              ),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.12),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.assignment_outlined,
                          size: 52,
                          color: color.withOpacity(0.85),
                        ),
                        Positioned(
                          bottom: 14,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.search_off_rounded,
                              size: 18,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // العنوان
            const Text(
              "لا توجد طلبات",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Tajawal",
                color: Color(0xff1F3E6C),
              ),
            ),
            const SizedBox(height: 10),

            // النص التوضيحي
            Text(
              "لم يتم العثور على أي طلبات  \nستظهر طلباتك هنا بمجرد إنشائها.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Tajawal",
                color: Colors.grey.shade500,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 32),

          ],
        ),
      ),
    );
  }

  Widget _buildDot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}