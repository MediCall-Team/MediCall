import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/api/dio_consumer.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/services/noti/local_notification_services.dart';
import 'package:grad_project/patient/features/notification/presentation/view_model/notification_number/notification_number_cubit.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? fcmToken;
  static String deviceId = "";

  /// ================= INIT =================
  static Future init() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await Future.delayed(const Duration(seconds: 1));

    /// 🔥 جلب التوكن بشكل آمن
    await _initFCMToken();

    log("FCM Token : ${fcmToken ?? "null"} , device ID $deviceId");

    /// 👇 check + retry logic
    await _checkAndUpdateToken();

    /// 👇 listen لأي refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      log("FCM Token Refreshed: $newToken");

      fcmToken = newToken;

      await CacheHelper.saveData(key: fcmSentKey, value: false);

      if (await AuthService.isLoggedIn()) {
        await sendToken(newToken, deviceId);
      }
    });

    /// background
    FirebaseMessaging.onBackgroundMessage(handelbackgroundMessage);

    /// foreground
    handelforgroundMessage();
  }

  /// ================= SAFE TOKEN INIT =================
  static Future<void> _initFCMToken() async {
    for (int i = 0; i < 5; i++) {
      try {
        final token = await messaging.getToken();

        if (token != null && token.isNotEmpty) {
          fcmToken = token;
          deviceId = await DeviceService.getDeviceId();

          log("✅ FCM Token: $fcmToken");
          return;
        }
      } catch (e) {
        log("❌ FCM attempt ${i + 1} failed: $e");
      }

      await Future.delayed(const Duration(seconds: 2));
    }

    log("⚠️ FCM token not available now, will retry later");
  }

  /// ================= CHECK TOKEN =================
  static Future _checkAndUpdateToken() async {
    if (fcmToken == null) return;

    final savedToken = CacheHelper.getData(key: fcmTokenKey);
    final isSent = CacheHelper.getData(key: fcmSentKey);

    final isLoggedIn = await AuthService.isLoggedIn();

    // 🔥 الحالة 1: التوكن اتغير
    if (savedToken != fcmToken && isLoggedIn) {
      log("Token changed → resend");
      await sendToken(fcmToken!, deviceId);
      return;
    }

    // 🔥 الحالة 2: التوكن متبعتش قبل كدا
    if (isSent != true && isLoggedIn) {
      log("Token not sent → retry");
      await sendToken(fcmToken!, deviceId);
    }
  }

  /// ================= AFTER LOGIN =================
  static Future syncTokenAfterLogin() async {
    if (fcmToken == null) {
      await _initFCMToken(); // 🔥 retry بعد login
    }

    if (fcmToken != null) {
      await sendToken(fcmToken!, deviceId);
    }
  }

  /// ================= FOREGROUND =================
  static void handelforgroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Notification title : ${message.notification?.title}");
      log("Notification body : ${message.notification?.body}");

      final String type = message.data["type"];
            
      if(type=="chat_message"){

         getIt<NotificationNumberCubit>().getMyChatNotificationsNumber();
         print("receive chat noti ..push");
      }else{

           getIt<NotificationNumberCubit>().getMyNotificationsNumber();
      print("receive noti ..push");
      }

      LocalNotificationService.showBasicNotification(message);
    });
  }
}

/// ================= BACKGROUND =================
Future<void> handelbackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  log("Background notification: ${message.notification?.title}");
}

/// ================= SEND TOKEN =================
Future<void> sendToken(String token, String deviceId) async {
  try {
    DioConsumer api = DioConsumer(dio: getIt<Dio>());

    await api.post(
      "api/Notifications/SaveToken",
      data: {
        "DeviceToken": token,
        "DeviceId": deviceId,
      },
    );

    // ✅ نجاح
    await CacheHelper.saveData(key: fcmSentKey, value: true);
    await CacheHelper.saveData(key: fcmTokenKey, value: token);
    await CacheHelper.saveData(key: "device_id", value: deviceId);

    log("✅ FCM sent successfully");
  } catch (e) {
    // ❌ فشل (هيحاول تاني بعدين)
    await CacheHelper.saveData(key: fcmSentKey, value: false);

    log("❌ FCM send failed: $e");
  }
}

/// ================= DEVICE ID =================
class DeviceService {
  static const _key = "device_id";

  static Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    String? deviceId = prefs.getString(_key);

    if (deviceId != null) {
      return deviceId;
    }

    deviceId = const Uuid().v4();

    await prefs.setString(_key, deviceId);

    return deviceId;
  }
}

/// ================= AUTH CHECK =================
class AuthService {
  static Future<bool> isLoggedIn() async {
    var user = CacheHelper.getUser();
    return user != null;
  }
}



// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:grad_project/constants.dart';
// import 'package:grad_project/core/helper/chach_helper.dart';
// import 'package:grad_project/core/utils/api/dio_consumer.dart';
// import 'package:grad_project/core/utils/get_it.dart';
// import 'package:grad_project/core/utils/services/noti/local_notification_services.dart';
// import 'package:grad_project/patient/features/authentication/data/patient_user_model.dart';
// import 'package:grad_project/patient/features/notification/presentation/view_model/notification_number/notification_number_cubit.dart';
// import 'package:uuid/uuid.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PushNotificationServices {
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;

//   static String? fcmToken;
//   static String deviceId = "";
  

//   static const _tokenKey = "fcm_token";

//   /// ================= INIT =================
//   static Future init() async {
//     await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     await Future.delayed(const Duration(seconds: 1));

//     try {
//       fcmToken = await messaging.getToken();
//       deviceId = await DeviceService.getDeviceId();
//     } catch (e) {
//       log("First attempt failed, retrying...");
//       await Future.delayed(const Duration(seconds: 3));
//       fcmToken = await messaging.getToken();
//     }

//     log("FCM Token : ${fcmToken ?? "null"} , device ID $deviceId");

//     /// 👇 check لو التوكن اتغير (مهم جدًا)
//     await _checkAndUpdateToken();

//     /// 👇 listen لأي refresh
//     FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
//       log("FCM Token Refreshed: $newToken");

//       fcmToken = newToken;

//      // await _saveToken(newToken);

//       await CacheHelper.saveData(key: fcmSentKey, value: false);

//       if (await AuthService.isLoggedIn()) {
//         await sendToken(newToken, deviceId);
//       }
//     });

//     /// background
//     FirebaseMessaging.onBackgroundMessage(handelbackgroundMessage);

//     /// foreground
//     handelforgroundMessage();
//   }

//   /// ================= CHECK TOKEN =================
//   // static Future _checkAndUpdateToken() async {
//   //   if (fcmToken == null) return;

//   //   final savedToken = await _getSavedToken();

//   //   if (savedToken != fcmToken) {
//   //     log("Token changed or first time");

//   //     await _saveToken(fcmToken!);

//   //     if (await AuthService.isLoggedIn()) {
//   //       await sendToken(fcmToken!, deviceId);
//   //     }
//   //   }
//   // }

// static Future _checkAndUpdateToken() async {
//   if (fcmToken == null) return;

//   final savedToken = CacheHelper.getData(key: fcmTokenKey);
//   final isSent = CacheHelper.getData(key: fcmSentKey);

//   final isLoggedIn = await AuthService.isLoggedIn();

//   // 🔥 الحالة 1: التوكن اتغير
//   if (savedToken != fcmToken && isLoggedIn) {
//     log("Token changed → resend");
//     await sendToken(fcmToken!, deviceId);
//     return;
//   }

//   // 🔥 الحالة 2: التوكن متبعتش قبل كدا
//   if (isSent != true && isLoggedIn) {
//     log("Token not sent → retry");
//     await sendToken(fcmToken!, deviceId);
//   }
// }


//   /// ================= AFTER LOGIN =================
//   static Future syncTokenAfterLogin() async {
//     if (fcmToken != null) {
//       await sendToken(fcmToken!, deviceId);
      
//      // await _saveToken(fcmToken!);
//     }
//   }

//   /// ================= CACHE =================
//   // static Future _saveToken(String token) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   await prefs.setString(_tokenKey, token);
 
//   // }

//   // static Future<String?> _getSavedToken() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   return prefs.getString(_tokenKey);
//   // }

//   /// ================= FOREGROUND =================
//   static void handelforgroundMessage() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log("Notification title : ${message.notification?.title}");
//       log("Notification body : ${message.notification?.body}");

//       // استدعاء الكيوبت لتحديث الرقم فوراً
//     getIt<NotificationNumberCubit>().getMyNotificationsNumber();
    
//       LocalNotificationService.showBasicNotification(message);
//     });
//   }
// }

// /// ================= BACKGROUND =================
// Future<void> handelbackgroundMessage(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   log("Background notification: ${message.notification?.title}");
// }

// /// ================= SEND TOKEN =================
// // Future<void> sendToken(String token, String deviceId) async {
// //   try {
// //    DioConsumer api = DioConsumer(dio: getIt<Dio>());

// //     var response = await api.post(
// //       "",
// //       data: {
// //         "fcmToken": token,
// //         "deviceType": "android",
// //         "deviceId": deviceId
// //       },
// //     );

// //     log("sendToken response : $response");
// //   } catch (e) {
// //     log("Error sending token : ${e.toString()}");
// //   }
// // }

// Future<void> sendToken(String token, String deviceId) async {
//   try {
//     DioConsumer api = DioConsumer(dio: getIt<Dio>()); // يفضل interceptor بعدين

//     await api.post(
//       "api/Notifications/SaveToken",
//       data: {
//         "DeviceToken": token,
//       //  "deviceType": "android",
//         "DeviceId": deviceId,
//       },
//     );

//     // ✅ نجح
//     await CacheHelper.saveData(key: fcmSentKey, value: true);
//     await CacheHelper.saveData(key: fcmTokenKey, value: token);
//     await CacheHelper.saveData(key: deviceId, value: deviceId);

//     log("FCM sent successfully");
    

//   } catch (e) {
//     // ❌ فشل
//     await CacheHelper.saveData(key: fcmSentKey, value: false);


//     log("FCM send failed");
//   }
// }

// /// ================= DEVICE ID =================
// class DeviceService {
//   static const _key = "device_id";

//   static Future<String> getDeviceId() async {
//     final prefs = await SharedPreferences.getInstance();

//     String? deviceId = prefs.getString(_key);

//     if (deviceId != null) {
//       return deviceId;
//     }

//     deviceId = const Uuid().v4();

//     await prefs.setString(_key, deviceId);

//     return deviceId;
//   }
// }

// /// ================= AUTH CHECK =================

// class AuthService {
//   static Future<bool> isLoggedIn() async {
//    // final prefs = await SharedPreferences.getInstance();
//     var user=CacheHelper.getUser();
//     /// مثال: لو عندك token
//     return user != null;
//   }
// }

