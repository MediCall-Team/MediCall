import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/profile/data/report_model.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo.dart';
import 'package:meta/meta.dart';

part 'get_reports_state.dart';

class GetReportsCubit extends Cubit<GetReportsState> {
  GetReportsCubit(this.repo) : super(GetReportsInitial());
  final PatientProfileRepo repo;

  Future<void>getReports()async{
    emit(GetReportsLoading());
    var data = await repo.getReports();
   data.fold((failure){
    emit(GetReportsFailure(errorMsg: failure.errorMsg));
   }, (reports){
    emit(GetReportsSuccess(reportsList: reports));
   });

  }
}
