import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapView extends StatefulWidget {
  final List<LatLng> locations;
  final List<String> places;

  const LocationMapView({super.key, required this.locations, required this.places});

  @override
  State<LocationMapView> createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    for (int i = 0; i < widget.locations.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId('marker_$i'),
        position: widget.locations[i],
        infoWindow: InfoWindow(title: widget.places[i]),
      ));
    }

    // بعد ما نحط كل الماركرز، نحدد الكاميرا لتشمل كل الأماكن
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.locations.isNotEmpty) {
        final bounds = _calculateBounds(widget.locations);
        mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
      }
    });
  }

  /// حساب LatLngBounds لتشمل كل الأماكن
  LatLngBounds _calculateBounds(List<LatLng> locations) {
    double south = locations.first.latitude;
    double north = locations.first.latitude;
    double west = locations.first.longitude;
    double east = locations.first.longitude;

    for (final loc in locations) {
      if (loc.latitude < south) south = loc.latitude;
      if (loc.latitude > north) north = loc.latitude;
      if (loc.longitude < west) west = loc.longitude;
      if (loc.longitude > east) east = loc.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("خريطة الأماكن")),
      body: GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        initialCameraPosition: CameraPosition(
          target: widget.locations.isNotEmpty
              ? widget.locations.first
              : const LatLng(26.556, 31.695),
          zoom: 8,
        ),
        markers: _markers,
      ),
    );
  }
}
