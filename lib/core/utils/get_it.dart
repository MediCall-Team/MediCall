import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';
import 'package:grad_project/common/chat/presentation/view_model/messages_list/messages_list_cubit.dart';
import 'package:grad_project/common/chat/repo/chat_repo.dart';
import 'package:grad_project/common/chat/repo/chat_repo_imp.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/core/utils/api/dio_consumer.dart';
import 'package:grad_project/core/utils/services/chat/signl_r.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo.dart';
import 'package:grad_project/patient/features/authentication/repo/auth_repo_imp.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo_imp.dart';
import 'package:grad_project/patient/features/home/categories/view_model/repo/MoreReviewRepo.dart';
import 'package:grad_project/patient/features/notification/presentation/view_model/notification_number/notification_number_cubit.dart';
import 'package:grad_project/patient/features/notification/repo/noti_repo.dart';
import 'package:grad_project/patient/features/notification/repo/noti_repo_imp.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo.dart';
import 'package:grad_project/patient/features/profile/repo/patient_profile_repo_imp.dart';
import 'package:grad_project/patient/features/requests/repo/p_requests_repo.dart';
import 'package:grad_project/patient/features/requests/repo/p_requests_repo_imp.dart';
import 'package:grad_project/service_provider/features/auth/repo/sp_regester_repo.dart';
import 'package:grad_project/service_provider/features/auth/repo/spregister_repo_imp.dart';
import 'package:grad_project/service_provider/features/requests/repos/requests_repo.dart';
import 'package:grad_project/service_provider/features/requests/repos/requests_repo_imp.dart';

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

  getIt.registerLazySingleton<NotiRepo>(
    () => NotiRepoImp(api: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<RequestsRepo>(
    () => RequestsRepoImp(api: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<PRequestsRepo>(
    () => PRequestsRepoImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<NotificationNumberCubit>(
    () => NotificationNumberCubit(getIt<NotiRepo>()),
  );

    getIt.registerLazySingleton<ChatRepo>(
    () => ChatRepoImp(api: getIt<ApiConsumer>()),
  );

   getIt.registerLazySingleton<SignalRService>(() => SignalRService());

   // في نهاية ميثود setupServiceLocator
// التعديل الصحيح: ننشئ النسخة فوراً داخل القوسين
getIt.registerSingleton<MessagesListCubit>(
  MessagesListCubit(getIt<ChatRepo>()),
);

getIt.registerSingleton<ChatsLitsCubit>(
  ChatsLitsCubit(getIt<ChatRepo>()),
);
}
