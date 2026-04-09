import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:grad_project/service_provider/features/requests/repos/requests_repo.dart';

part 'request_management_state.dart';

class RequestManagementCubit extends Cubit<RequestManagementState> {
  RequestManagementCubit(this.repo) : super(RequestManagementInitial());

  final RequestsRepo repo;

  /// قبول الطلب
  Future<void> acceptRequest(int requestId) async {
    emit(RequestManagementLoading(requestId));

    final result = await repo.acceptRequest(requestId);

    result.fold(
      (failure) => emit(RequestManagementFailure(failure.errorMsg,requestId)),
      (message) => emit(RequestManagementSuccess(message,requestId)),
    );
  }

  /// رفض الطلب
  Future<void> rejectRequest(int requestId) async {
    emit(RequestManagementLoading(requestId));

    final result = await repo.rejectRequest(requestId);

    result.fold(
      (failure) => emit(RequestManagementFailure(failure.errorMsg,requestId)),
      (message) => emit(RequestManagementSuccess(message,requestId)),
    );
  }
}