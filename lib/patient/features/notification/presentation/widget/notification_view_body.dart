import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/helper/reusable_shimmer.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/authentication/data/patient_user_model.dart';
import 'package:grad_project/patient/features/notification/presentation/view_model/notification_number/notification_number_cubit.dart';
import 'package:grad_project/patient/features/notification/presentation/view_model/notifications/notifications_cubit.dart';
import 'package:grad_project/patient/features/notification/presentation/widget/notification_card.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key});

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  late ScrollController controller;
  late PatientUserModel user;

  @override
  void initState() {
    super.initState();
    user = CacheHelper.getUser()!;
    controller = ScrollController();

    // طلب أول صفحة عند فتح الشاشة
    context.read<NotificationsCubit>().loadFirstPage();

    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        context.read<NotificationsCubit>().loadMore();
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
    final double width = MediaQuery.of(context).size.width;
    final bool isTablet = width > 500;
    double titleFontSize = (width * 0.06).clamp(20, 30);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: BlocListener<NotificationsCubit, NotificationsState>(
          listenWhen: (previous, current) =>
              current is NotificationsSuccess && previous is! NotificationsSuccess,
          listener: (context, state) {
            if (state is NotificationsSuccess && state.notificationList.isNotEmpty) {
              // تحديث حالة القراءة وتصفير الرقم في الـ Cubit
             // context.read<NotificationNumberCubit>().readNotifications();
             Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.read<NotificationNumberCubit>().readNotifications();
      }
    });
            }
          },
          child: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              return CustomScrollView(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1. Header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            'الإشعارات',
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.mainContrast(context),
                              fontFamily: "Tajawal",
                            ),
                          ),
                          const Spacer(),
                          if (!isTablet && user.role == "Patient")
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                color: const Color(0xff1F3E6C),
                                size: (width * 0.07).clamp(24, 32),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // 2. المحتوى (Loading, Failure, or Data)
                  if (state is NotificationsLoading)
                    _buildFirstLoadShimmer()
                  else if (state is NotificationsFailure)
                    SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            state.errorMsg,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    )
                  else if (state is NotificationsSuccess) ...[
                    if (state.notificationList.isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.only(bottom: 20),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = state.notificationList[index];
                              return NotificationCard(
                                isRead: item.isRead ?? true,
                                icon: 'assets/images/calendar2.png',
                                title: item.title ?? 'بدون عنوان',
                                subtitle: item.content ?? '',
                                time: item.createdAt ?? '',
                              );
                            },
                            childCount: state.notificationList.length,
                          ),
                        ),
                      )
                    else
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            "لا توجد إشعارات",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Tajawal",
                            ),
                          ),
                        ),
                      ),

                    // Shimmer عند Pagination
                    if (state.isLoadingMore)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: ReusableShimmer(),
                        ),
                      ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFirstLoadShimmer() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ReusableShimmer(),
          ),
          childCount: 6,
        ),
      ),
    );
  }
}