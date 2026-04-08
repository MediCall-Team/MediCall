class RequestsModel {
  final int pageIndex;
  final int pageSize;
  final int count;
  final List<RequestData> data;

  RequestsModel({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.data,
  });

  factory RequestsModel.fromJson(Map<String, dynamic> json) {
    return RequestsModel(
      pageIndex: json['pageIndex'],
      pageSize: json['pageSize'],
      count: json['count'],
      data: List<RequestData>.from(
        json['data'].map((x) => RequestData.fromJson(x)),
      ),
    );
  }
}
class RequestData {
  final int requestId;
  final String patientFirstName;
  final String patientLastName;
  final String patientImage;
  final String? description;
  final DateTime createdAt;
  final DateTime appointmentDate;
  final double latitude;
  final double longitude;
  final int status;

  RequestData({
    required this.requestId,
    required this.patientFirstName,
    required this.patientLastName,
    required this.patientImage,
    this.description,
    required this.createdAt,
    required this.appointmentDate,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) {
    return RequestData(
      requestId: json['requestId'],
      patientFirstName: json['patientFirstName'] ?? '',
      patientLastName: json['patientLastName'] ?? '',
      patientImage: json['patientImage'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      appointmentDate: DateTime.parse(json['appointmentDate']),
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'patientFirstName': patientFirstName,
      'patientLastName': patientLastName,
      'patientImage': patientImage,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'appointmentDate': appointmentDate.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }

  String get statusText {
    switch (status) {
      case 1:
        return 'قيد المراجعة';
      case 2:
        return 'تمت الموافقة';
      case 3:
        return 'مرفوض';
      case 4:
        return 'مكتمل';
      case 5:
        return 'ملغي';
      default:
        return 'حالة غير معروفة';
    }
  }
}