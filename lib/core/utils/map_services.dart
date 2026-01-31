import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  /// يحول List أسماء الأماكن لإحداثيات LatLng
  static Future<List<LatLng>> getLocationsFromNames(List<String> places) async {
    final List<LatLng> locations = [];

    for (final place in places) {
      try {
        final result = await locationFromAddress(place);
        if (result.isNotEmpty) {
          final loc = result.first;
          locations.add(LatLng(loc.latitude, loc.longitude));
        }
      } catch (e) {
        // تجاهل الأخطاء لو مكان مش متعرف
      }
    }

    return locations;
  }
}
