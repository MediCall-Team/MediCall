import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/core/utils/api/dio_consumer.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo_imp.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo_imp.dart';
import 'package:grad_project/patient/features/home/categories/repo/more_review_repo.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo_imp.dart';
import 'package:grad_project/service_provider/features/auth/repo/sp_regester_repo.dart';
import 'package:grad_project/service_provider/features/auth/repo/spregister_repo_imp.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  /// Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  /// ApiConsumer
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );

  /// AuthRepo
  getIt.registerLazySingleton<PatienAuthRepo>(
    () => PatienAuthRepoImp(api: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<SpRegesterRepo>(
    () => SpregisterRepoImp(api: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<CategoriesRepo>(
    () => CategoriesRepoImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<PatientProfileRepo>(
    () => PatientProfileRepoImp(api: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<MoreReviewRepo>(
    () => MoreReviewRepoImp(api: getIt<ApiConsumer>()),
  );
}
