import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;

/// خدمة الموقع
class LocationService {
  final loc.Location location = loc.Location();

  /// التحقق من تشغيل GPS
  Future<void> checkAndRequestLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw LocationServiceException();
      }
    }
  }

  /// التحقق من صلاحية الوصول للموقع
  Future<void> checkAndRequestLocationPermission() async {
    loc.PermissionStatus permissionStatus = await location.hasPermission();

    if (permissionStatus == loc.PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }

    if (permissionStatus == loc.PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != loc.PermissionStatus.granted) {
        throw LocationPermissionException();
      }
    }
  }

  /// جلب الموقع الحالي مع العنوان
  Future<Map<String, dynamic>> getLocationData() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();

    loc.LocationData locData = await location.getLocation();

    double lat = locData.latitude ?? 0.0;
    double long = locData.longitude ?? 0.0;

    // تحويل الإحداثيات لعنوان
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(lat, long);
    geo.Placemark place = placemarks.first;

    String address = "${place.country} - ${place.locality}";

    return {
      "lat": lat,
      "long": long,
      "address": address,
    };
  }

  /// التحديث المستمر لمكان المستخدم
  void getRealTimeLocationData(void Function(loc.LocationData)? onData) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.onLocationChanged.listen(onData);
  }
}

/// Exceptions مخصصة
class LocationServiceException implements Exception {}
class LocationPermissionException implements Exception {}