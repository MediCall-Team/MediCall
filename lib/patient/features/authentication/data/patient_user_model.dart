
import 'package:jwt_decoder/jwt_decoder.dart';

// class UserModel{
//   final String fullName, email , token ;

//   UserModel({required this.fullName, required this.email, required this.token});

//   factory UserModel.fromJson(json){
//     return UserModel(fullName:json["fullName"] , email: json["email"], token: json["token"]);
//   }
// }

class PatientUserModel {
  final String id;
  final String fullName;
  final String email;
  final String token;
  final String role;

  PatientUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.token,
    required this.role,
  });

  factory PatientUserModel.fromJson( Map<String, dynamic> json) {

    // decode jwt token
    var decodedToken = JwtDecoder.decode(json["token"]);

    return PatientUserModel(
      id: decodedToken["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"],
      fullName: json["fullName"],
      email: json["email"],
      token: json["token"],
      role: decodedToken["http://schemas.microsoft.com/ws/2008/06/identity/claims/role"], // جاي من التوكين
    );
  }
}