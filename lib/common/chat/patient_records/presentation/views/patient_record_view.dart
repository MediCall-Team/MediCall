import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/common/chat/patient_records/presentation/view_model/cubit/patient_record_cubit.dart';
import 'package:grad_project/common/chat/patient_records/repo/patient_record_repo.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/profile/presentation/widgets/MedicalRecordItem.dart';

class PatientRecordView extends StatelessWidget {
  const PatientRecordView({super.key, required this.patientId});

  final int patientId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PatientRecordCubit(getIt<PatientRecordRepo>())
        ..getPtientRecord(patientId: patientId),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'السجل المرضي',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppTheme.mainContrast(context),
              ),
            ),
          ),
          body: BlocBuilder<PatientRecordCubit, PatientRecordState>(
            builder: (context, state) {
              if (state is PatientRecordLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.brandColor(context),
                  ),
                );
              } else if (state is PatientRecordSuccess) {
                if (state.reportsList.isEmpty) {
                  return const Center(
                    child: Text("لا يوجد سجلات طبية لهذا المريض"),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.reportsList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return MedicalRecordItem(
                      report: state.reportsList[index],
                    );
                  },
                );
              } else if (state is PatientRecordFailure) {
                return Center(child: Text(state.errmsg));
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}