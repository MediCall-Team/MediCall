import 'package:bloc/bloc.dart';
import 'package:grad_project/service_provider/features/requests/repos/Service_profile_Repo.dart';
import 'git_s_p_state.dart';

class GitSPCubit extends Cubit<GitSPState> {
  final SPProfileRepo repo;

  GitSPCubit(this.repo) : super(GitSPInitial());

  Future<void> getProviderProfile() async {
    emit(GitSPLoading());

    final result = await repo.getProviderProfile();

    result.fold(
      (failure) {
        print('❌ خطأ في جلب البيانات: ${failure.errorMsg}');
        emit(GitSPFailure(failure.errorMsg));
      },
      (profile) {
        // 🔹 طباعة الداتا في الكونصل عشان تطمن
        print('=================================');
        print('✅ تم جلب البيانات بنجاح!');
        print('الاسم: ${profile.firstName} ${profile.lastName}');
        print('الإيميل: ${profile.email}');
        print('رقم الهاتف: ${profile.phoneNumber}');
        print('السعر: ${profile.price}');
        print(
          'المراكز: ${profile.doctorServiceAreas.map((e) => e.name).toList()}',
        );
        print('=================================');

        emit(GitSPSuccess(profile));
      },
    );
  }
}
