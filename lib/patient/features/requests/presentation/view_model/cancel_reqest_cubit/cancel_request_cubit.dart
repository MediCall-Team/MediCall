import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/requests/repo/p_requests_repo.dart';
import 'package:meta/meta.dart';

part 'cancel_request_state.dart';

class CancelRequestCubit extends Cubit<CancelRequestState> {
  CancelRequestCubit(this.repo) : super(CancelRequestInitial());
  final PRequestsRepo repo;

  /// قبول الطلب
  Future<void> acceptRequest(int requestId) async {
    emit(CancelRequestLoading());

    final result = await repo.cancelRequest(requestId:requestId);

    result.fold(
      (failure) => emit(CancelRequestFailure(failure.errorMsg)),
      (message) => emit(CancelRequestSuccess(message)),
    );
  }

}
