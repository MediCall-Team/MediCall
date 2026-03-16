import 'dart:io';

import 'package:flutter/material.dart';

enum Gender { male, female }

extension GenderExtension on Gender {
  int get value {
    switch (this) {
      case Gender.male:
        return 1;
      case Gender.female:
        return 2;
    }
  }
}

class RegisterRequestModel {
   File image;
   String firstName;
   String lastName;
   String phone;
   String password;
   String specialization;
  double? price;
   Gender gender;
   List<File> certificates;
   double lat;
   double lng;
   String email;

  RegisterRequestModel({
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.specialization,
    this.price,
    required this.gender,
    required this.certificates,
    required this.lat,
    required this.lng,
    required this.email,
  });
}