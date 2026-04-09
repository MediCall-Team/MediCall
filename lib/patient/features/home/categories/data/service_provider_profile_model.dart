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
      places: (json["serviceAreas"] as List?)
    ?.map((e) => e["name"].toString()) // هنا بنسحب الـ name من جوا الـ Map
    .toList() ?? [],

      spReviews: ServiceProviderReviewsModel.fromJson(json),
    );
  }

}

