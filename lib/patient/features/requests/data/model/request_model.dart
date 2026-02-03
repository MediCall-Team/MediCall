class RequestModel {
  final String id;
  final String description,status,dcName;
  final Location location;
  final DateTime createdAt,date;

  RequestModel({required this.id, required this.description, required this.status, required this.location, required this.createdAt, required this.date, required this.dcName});
}

class Location{
  final double lng,lat;
  Location({required this.lng, required this.lat});
}