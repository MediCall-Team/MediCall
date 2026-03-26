import 'dart:core';

class PatientProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePictureUrl;

  PatientProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePictureUrl,
  });
 factory PatientProfileModel.fromJson(Map<String, dynamic> json) {
  return PatientProfileModel(
    firstName: json['firstName'] ,
    lastName: json['lastName'] ,
    email: json['email'] ,
    phoneNumber: json['phoneNumber'],
    profilePictureUrl: json['profilePictureUrl'],
  );
}
}
