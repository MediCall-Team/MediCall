import 'package:dio/dio.dart';
import 'package:grad_project/core/helper/chach_helper.dart';

// class ApiInterceptor extends Interceptor {
//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) {
//     final token = CacheHelper.getData(key: 'token');

//     if (token != null && token.toString().isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }

//     handler.next(options); // الأفضل من super
//   }
// }
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler) {

    final token = CacheHelper.getUser()?.token;

    print("🔥 TOKEN: $token");

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
