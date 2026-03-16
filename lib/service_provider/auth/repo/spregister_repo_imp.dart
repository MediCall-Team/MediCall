// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:grad_project/core/error/failure.dart';
// import 'package:grad_project/core/utils/api/api_consumer.dart';
// import 'package:grad_project/service_provider/auth/data/s_p_regester_model.dart';
// import 'package:grad_project/service_provider/auth/repo/sp_regester_repo.dart';

// class SpregisterRepoImp extends SpRegesterRepo {
//   final ApiConsumer api;

//   SpregisterRepoImp({required this.api});
//   @override
//   Future<Either<Failure, String>> SpRegesteration({
//     required RegisterRequestModel registermodel,
//   }) async {
    
//     try {
//       List<MultipartFile> certFiles = [];

//       for (var file in registermodel.certificates) {
//         certFiles.add(await MultipartFile.fromFile(file.path));
//       }

//       FormData formdata = FormData.fromMap({
//         "ProfileImage": await MultipartFile.fromFile(registermodel.image.path),
//         "FirstName": registermodel.firstName,
//         "LastName": registermodel.lastName,
//         "PhoneNumber": registermodel.phone,
//         "Password": registermodel.password,
//         "Specialization": registermodel.specialization,
//         "Price": registermodel.price,
//         "Gender": registermodel.gender.value,
//         "Longitude": registermodel.lng,
//         "Latitude": registermodel.lat,
//         "Email": registermodel.email,
//         "Certificates": certFiles,
//       });

//       var response = await api.post(
//         "api/Authentication/RegisterProvider",
//         data: formdata,
//       );

//       return right(response['message']);
//     } on Failure catch (e) {
//       return left(e);
//     } catch (e) {
//       return left(ServerFailure(e.toString()));
//     }
//   }
// }