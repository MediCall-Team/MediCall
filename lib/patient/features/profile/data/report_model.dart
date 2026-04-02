class ReportModel {
  final int? id;
  final String? description;
  final DateTime? createdAt;
  final String? patientFirstName;
  final String? patientLastName;
  final String? providerImage;
  final String? providerFirstName;
  final String? providerLastName;
  final String? providerSpecialization;
  final int? serviceProviderId;
  final int? requestId;
  final bool? isReviewed;

  ReportModel({
    this.id,
    this.description,
    this.createdAt,
    this.patientFirstName,
    this.patientLastName,
    this.providerImage,
    this.providerFirstName,
    this.providerLastName,
    this.providerSpecialization,
    this.serviceProviderId,
    this.requestId,
    this.isReviewed,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      description: json['description'],
      // تحويل النص إلى DateTime للتعامل معه برمجياً (زي حساب الوقت منذ الإنشاء)
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt']) 
          : null,
      patientFirstName: json['patientFirstName'],
      patientLastName: json['patientLastName'],
      providerImage: json['providerImage'],
      providerFirstName: json['providerFirstName'],
      providerLastName: json['providerLastName'],
      providerSpecialization: json['providerSpecialization'],
      serviceProviderId: json['serviceProviderId'],
      requestId: json['requestId'],
      isReviewed: json['isReviewed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'patientFirstName': patientFirstName,
      'patientLastName': patientLastName,
      'providerImage': providerImage,
      'providerFirstName': providerFirstName,
      'providerLastName': providerLastName,
      'providerSpecialization': providerSpecialization,
      'serviceProviderId': serviceProviderId,
      'requestId': requestId,
      'isReviewed': isReviewed,
    };
  }

  // ميثود مساعدة لدمج الاسم بالكامل
  String get providerFullName => '$providerFirstName $providerLastName'.trim();
  String get patientFullName => '$patientFirstName $patientLastName'.trim();
}