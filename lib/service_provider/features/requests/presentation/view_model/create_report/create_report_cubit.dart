import 'package:bloc/bloc.dart';
import 'package:grad_project/service_provider/features/requests/repos/requests_repo.dart';
import 'package:meta/meta.dart';

part 'create_report_state.dart';

class CreateReportCubit extends Cubit<CreateReportState> {
  CreateReportCubit(this.repo) : super(CreateReportInitial());
   final RequestsRepo repo;
    Future<void> acceptRequest(int requestId,String description) async {
    emit(CreateReportLoading());

    final result = await repo.createReport(requestId,description);

    result.fold(
      (failure) => emit(CreateReportFailure(failure.errorMsg)),
      (message) => emit(CreateReportSuccess(message)),
    );
  }
}
