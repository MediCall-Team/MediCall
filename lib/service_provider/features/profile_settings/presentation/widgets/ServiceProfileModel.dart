class ProviderProfileModel {
  final String firstName;
  final String lastName;
  final String? image;
  final double? longitude;
  final double? latitude;
  final String email;
  final String phoneNumber;
  final String bio;
  final double price;
  final bool isActive;
  final List<DoctorServiceArea> doctorServiceAreas;

  ProviderProfileModel({
    required this.firstName,
    required this.lastName,
    this.image,
    this.longitude,
    this.latitude,
    required this.email,
    required this.phoneNumber,
    required this.bio,
    required this.price,
    required this.isActive,
    required this.doctorServiceAreas,
  });

  factory ProviderProfileModel.fromJson(Map<String, dynamic> json) {
    final doctorAreas =
        (json['doctorServiceAreas'] as List?)
            ?.map((e) => DoctorServiceArea.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    return ProviderProfileModel(
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      image: json['image']?.toString(),
      longitude: (json['longitude'] != null)
          ? (json['longitude'] as num).toDouble()
          : null,
      latitude: (json['latitude'] != null)
          ? (json['latitude'] as num).toDouble()
          : null,
      email: json['email']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : 0.0,
      isActive: json['isActive'] is bool
          ? json['isActive']
          : (json['isActive'] == 1),
      doctorServiceAreas: doctorAreas,
    );
  }
}

class DoctorServiceArea {
  final int id;
  final String name;

  DoctorServiceArea({required this.id, required this.name});

  factory DoctorServiceArea.fromJson(Map<String, dynamic> json) {
    return DoctorServiceArea(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}
