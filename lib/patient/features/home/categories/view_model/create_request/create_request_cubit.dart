import 'package:bloc/bloc.dart';
import 'package:grad_project/patient/features/home/categories/data/create_request_model.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:meta/meta.dart';

part 'create_request_state.dart';

class CreateRequestCubit extends Cubit<CreateRequestState> {
  CreateRequestCubit(this.repo) : super(CreateRequestInitial());
  final CategoriesRepo repo;
  bool loading =false;

  Future<void>createRequest({required CreateRequestModel createRequestModel})async{
    loading=true;
    emit(CreateRequestLoading());
    var data = await repo.createRequest(createRequestModel: createRequestModel);

    data.fold((failure){
      emit(CreateRequestFailure(errorMsg: failure.errorMsg));
    }, (_){
      emit(CreateRequestSuccess());
    });
    loading=false;
  }
}
