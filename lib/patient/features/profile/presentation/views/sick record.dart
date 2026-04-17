import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/categories/view_model/add_review/add_review_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/view_model/get_reports/get_reports_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/MedicalRecordItem.dart';

class MedicalRecordView extends StatefulWidget {
  const MedicalRecordView({super.key});

  @override
  State<MedicalRecordView> createState() => _MedicalRecordViewState();
}

class _MedicalRecordViewState extends State<MedicalRecordView> {
  @override
  void initState() {
    super.initState();
    context.read<GetReportsCubit>().getReports();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddReviewCubit(getIt<CategoriesRepo>()),
      child: Builder(
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'سجل الحالة الطبية',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppTheme.mainContrast(context),
                  ),
                ),
              ),
              body: BlocListener<AddReviewCubit, AddReviewState>(
                listener: (context, state) {
                  if (state is AddReviewSuccess) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text('تم إضافة التقييم بنجاح'),
                    //     backgroundColor: Colors.green,
                    //   ),
                    // );
                     snackBarMethod(context, 'تم إضافة التقييم بنجاح');

                    /// 🔥 إعادة تحميل الداتا
                    context.read<GetReportsCubit>().getReports();
                  } else if (state is AddReviewFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMsg),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<GetReportsCubit, GetReportsState>(
                  builder: (context, state) {
                    if (state is GetReportsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.brandColor(context),
                        ),
                      );
                    } else if (state is GetReportsSuccess) {
                      if (state.reportsList.isEmpty) {
                        return const Center(
                          child: Text("لا يوجد سجلات طبية حالياً"),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.reportsList.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return MedicalRecordItem(
                            report: state.reportsList[index],
                          );
                        },
                      );
                    } else if (state is GetReportsFailure) {
                      return Center(child: Text(state.errorMsg));
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}