import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:grad_project/service_provider/auth/data/s_p_regester_model.dart';
import 'package:grad_project/service_provider/auth/repo/sp_regester_repo.dart';
import 'package:grad_project/service_provider/auth/repo/spregister_repo_imp.dart';
import 'package:meta/meta.dart';

part 'sp_register_state.dart';

class SpRegisterCubit extends Cubit<SpRegisterState> {
  SpRegisterCubit(this.spregisterRepo) : super(SpRegisterInitial());
  final SpRegesterRepo spregisterRepo;
 final RegisterRequestModel model = RegisterRequestModel(
    image: File(''), // قيمة افتراضية
    firstName: '',
    lastName: '',
    phone: '',
    password: '',
    specialization: '',
    gender: Gender.male,
    certificates: [],
    lat: 0.0,
    lng: 0.0,
    email: '',
  );
  void setBasicInfo({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String email,
     required File image,
  }) {
print("Step 1: Basic info set: $firstName, $lastName, $email");
print("Selected image: ${image.path}");

    model.firstName = firstName;
    model.lastName = lastName;
    model.phone = phone;
    model.password = password;
    model.email = email;
    model.image=image;
    
  }

  /// screen 2 data
  void setProfessionalInfo({
    
    required String specialization,
    double? price,
    required Gender gender,
    required double lat,
    required double lng,
  }) {
print("Step 1: Basic info set: $gender, $lat, $lng");
    model.specialization = specialization;
    model.price = price;
    model.gender = gender;
    model.lat = lat;
    model.lng = lng;
  }

  /// screen 3 data
  void setCertificates({
    
   
    required List<File> certificates,
  }) {

    print("Selected certificates: ${certificates.map((e) => e.path).toList()}");
    model.certificates = certificates;
  }

  Future<void> register() async {
    emit(SpRegisterLoading());
var data= await spregisterRepo.SpRegesteration(registermodel: model);

 data.fold(
      (failure) {
        emit(SpRegisterFailure(failure.errorMsg));
      },
      (msg) {
        emit(SpRegisterSuccess());
      },
    );
  }

}
