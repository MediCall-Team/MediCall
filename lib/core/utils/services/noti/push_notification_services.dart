import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/api/dio_consumer.dart';
import 'package:grad_project/core/utils/services/noti/local_notification_services.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? fcmToken;
  static String deviceId = "";

  static const _tokenKey = "fcm_token";

  /// ================= INIT =================
  static Future init() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await Future.delayed(const Duration(seconds: 1));

    try {
      fcmToken = await messaging.getToken();
      deviceId = await DeviceService.getDeviceId();
    } catch (e) {
      log("First attempt failed, retrying...");
      await Future.delayed(const Duration(seconds: 3));
      fcmToken = await messaging.getToken();
    }

    log("FCM Token : ${fcmToken ?? "null"} , device ID $deviceId");

    /// 👇 check لو التوكن اتغير (مهم جدًا)
    await _checkAndUpdateToken();

    /// 👇 listen لأي refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      log("FCM Token Refreshed: $newToken");

      fcmToken = newToken;

      await _saveToken(newToken);

      if (await AuthService.isLoggedIn()) {
        await sendToken(newToken, deviceId);
      }
    });

    /// background
    FirebaseMessaging.onBackgroundMessage(handelbackgroundMessage);

    /// foreground
    handelforgroundMessage();
  }

  /// ================= CHECK TOKEN =================
  static Future _checkAndUpdateToken() async {
    if (fcmToken == null) return;

    final savedToken = await _getSavedToken();

    if (savedToken != fcmToken) {
      log("Token changed or first time");

      await _saveToken(fcmToken!);

      if (await AuthService.isLoggedIn()) {
        await sendToken(fcmToken!, deviceId);
      }
    }
  }

  /// ================= AFTER LOGIN =================
  static Future syncTokenAfterLogin() async {
    if (fcmToken != null) {
      await sendToken(fcmToken!, deviceId);
      await _saveToken(fcmToken!);
    }
  }

  /// ================= CACHE =================
  static Future _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> _getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// ================= FOREGROUND =================
  static void handelforgroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Notification title : ${message.notification?.title}");
      log("Notification body : ${message.notification?.body}");

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
    DioConsumer api = DioConsumer(dio: Dio());

    var response = await api.post(
      "",
      data: {
        "fcmToken": token,
        "deviceType": "android",
        "deviceId": deviceId
      },
    );

    log("sendToken response : $response");
  } catch (e) {
    log("Error sending token : ${e.toString()}");
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
   // final prefs = await SharedPreferences.getInstance();
    var user=CacheHelper.getUser();
    /// مثال: لو عندك token
    return user != null;
  }
}



// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:grad_project/core/utils/api/dio_consumer.dart';
// import 'package:grad_project/core/utils/services/noti/local_notification_services.dart';
// import 'package:uuid/uuid.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PushNotificationServices {

//   static FirebaseMessaging messaging = FirebaseMessaging.instance;

//   static String? fcmToken;
//   static String deviceId="" ;

//   static Future init() async {

//     // طلب صلاحية الإشعارات
//     await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
  
//   await Future.delayed(const Duration(seconds: 1));

//    try {

//     fcmToken = await messaging.getToken();
//     deviceId = await DeviceService.getDeviceId();

//   } catch (e) {

//     log("First attempt failed, retrying...");
//     // محاولة ثانية بعد 3 ثواني لو فشلت الأولى
//     await Future.delayed(const Duration(seconds: 3));
//     fcmToken = await messaging.getToken();
    
//   }

//     log("FCM Token : ${fcmToken ?? "null"}");

//     // إرسال التوكين للسيرفر
//     if (fcmToken != null) {
//       await sendToken(fcmToken!,deviceId);
//     }

//       // 👇 لو Firebase غير التوكين
//   FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
//     log("FCM Token Refreshed: $newToken");
//     sendToken(newToken,deviceId);
//   });


//     // استقبال الرسائل في الخلفية
//     FirebaseMessaging.onBackgroundMessage(handelbackgroundMessage);

//     // استقبال الرسائل في foreground
//     handelforgroundMessage();
//   }

//   static void handelforgroundMessage() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {

//       log("Notification title : ${message.notification?.title}");
//       log("Notification body : ${message.notification?.body}");
//       // log("${message.notification?.android?.imageUrl ?? ""}");
//       // log("${message.toString()}");

//       // اظهار local notification
//       LocalNotificationService.showBasicNotification(message);
//     });
//   }
// }

// Future<void> handelbackgroundMessage(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   log("Background notification: ${message.notification?.title}");
// }

// Future<void> sendToken(String token,String deviceId) async {

//   try {

//     DioConsumer api = DioConsumer(dio: Dio());
    

//     var response = await api.post(
//       "",
//       data: {
//         "fcmToken": token,
//         "deviceType": "android",
//         "deviceId":deviceId
//       },
//     );
   
//     log("sendToken response : $response");

//   } catch (e) {

//     log("Error sending token : ${e.toString()}");

//   }

// }

// ///////////////////
// ///


// class DeviceService {
//   static const _key = "device_id";

//   static Future<String> getDeviceId() async {
//     final prefs = await SharedPreferences.getInstance();

//     String? deviceId = prefs.getString(_key);

//     if (deviceId != null) {
//       return deviceId;
//     }

//     // Generate new one
//     deviceId = const Uuid().v4();

//     await prefs.setString(_key, deviceId);

//     return deviceId;
//   }
// }