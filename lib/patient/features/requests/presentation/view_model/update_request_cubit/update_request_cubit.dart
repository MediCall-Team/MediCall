import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/requests/repo/p_requests_repo.dart';
import 'package:meta/meta.dart';

part 'update_request_state.dart';

class UpdateRequestCubit extends Cubit<UpdateRequestState> {
  UpdateRequestCubit(this.repo) : super(UpdateRequestInitial());
  final PRequestsRepo repo;
  bool loading = false;

  Future<void> updateRequest({
    required int requestId,
    required DateTime scheduledDate,
    required double latitude,
    required double longitude,
    required String description,
  }) async {
    loading = true;
    emit(UpdateRequestLoading());
    var data = await repo.updateRequest(
      requestId: requestId,
      scheduledDate: scheduledDate,
      latitude: latitude,
      longitude: longitude,
      description: description,
    );

    data.fold(
      (failure) {
        emit(UpdateRequestFailure(failure.errorMsg));
      },
      (_) {
        emit(UpdateRequestSuccess());
      },
    );
    loading = false;
  }
}
