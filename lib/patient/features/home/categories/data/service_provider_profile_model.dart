import 'package:grad_project/patient/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/patient/features/home/data/models/doctor_model.dart';

class ServiceProviderProfileModel {
  final DoctorModel doctorModel;
  final int homeVisits;
  final String? bio;
  // yearsofexperience,

  final List<String> places;
  final ServiceProviderReviewsModel spReviews;

  ServiceProviderProfileModel({
    required this.doctorModel,
    required this.homeVisits,
    // required this.yearsofexperience,
    required this.bio,
    required this.places,
    required this.spReviews,
  });

  ///

  factory ServiceProviderProfileModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderProfileModel(
      doctorModel: DoctorModel(
        image: json["imageUrl"] ?? "",
        name: json["fullName"] ?? "",
        specialty: json["title"] ?? "",
        rate: (json["averageRating"] ?? 0).toDouble(),
        price: (json["price"] ?? 0).toDouble(),
        id: json["id"],
      ),

      homeVisits: json["numberOfServices"] ?? "0",
      bio: json["bio"] ?? "",

      // ✅ تحويل الليست
      places:
          (json["serviceAreas"] as List?)?.map((e) => e.toString()).toList() ??
          [],

      spReviews: ServiceProviderReviewsModel.fromJson(json),
    );
  }

  // factory ServiceProviderProfileModel.formJson(json) {
  //   return ServiceProviderProfileModel(
  //     doctorModel: DoctorModel(
  //       image: json["imageUrl"],
  //       name: json["fullName"],
  //       specialty: json["title"],
  //       rate: json["averageRating"],
  //       price: json["price"],
  //       id: json["id"] ?? "",
  //     ),
  //     homeVisits: json["numberOfServices"],
  //     // yearsofexperience: yearsofexperience,
  //     bio: json["bio"],
  //     places: json["serviceAreas"],
  //     spReviews: ServiceProviderReviewsModel(
  //       rate: json["averageRating"],
  //       numPepoleRate: json["totalReviewsCount"],
  //       rateFive: json["starSummary"]["5"],
  //       rateFour: json["starSummary"]["4"],
  //       rateThree: json["starSummary"]["3"],
  //       rateTwo: json["starSummary"]["2"],
  //       rateOne: json["starSummary"]["1"],
  //       reviewsList: json["recentReviews"],
  //     ),
  //   );
  // }
}