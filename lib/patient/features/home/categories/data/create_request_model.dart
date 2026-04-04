class CreateRequestModel {
  final int serviceProviderId;
  final String patientFirstName;
  final String patientLastName;
  final String description;
  final DateTime scheduledDate;
  final double latitude;
  final double longitude;

  CreateRequestModel({
    required this.serviceProviderId,
    required this.patientFirstName,
    required this.patientLastName,
    required this.description,
    required this.scheduledDate,
    required this.latitude,
    required this.longitude,
  });

  // ميثود لتحويل الكلاس إلى Map لإرساله كـ JSON للسيرفر
  Map<String, dynamic> toJson() {
      
    return {
      'serviceProviderId': serviceProviderId,
      'PatientFirstName': patientFirstName,
      'PatientLastName': patientLastName,
      'description': description,
      'scheduledDate': scheduledDate.toUtc().toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };

  }

  // ميثود (Factory) لو احتجت تحول البيانات من JSON للكلاس
  factory CreateRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateRequestModel(
      serviceProviderId: json['serviceProviderId'],
      patientFirstName: json['PatientFirstName'] ?? '',
      patientLastName: json['PatientLastName'] ?? '',
      description: json['description'] ?? '',
      scheduledDate: DateTime.parse(json['scheduledDate']),
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }
}