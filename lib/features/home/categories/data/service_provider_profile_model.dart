import 'package:grad_project/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/features/home/models/doctor_model.dart';

class ServiceProviderProfileModel {
  final DoctorModel doctorModel;
  final String homeVisits, yearsofexperience, bio;
  final List<String> places;
  final ServiceProviderReviewsModel spReviews;

  ServiceProviderProfileModel({
    required this.doctorModel,
    required this.homeVisits,
    required this.yearsofexperience,
    required this.bio,
    required this.places,
    required this.spReviews,
  });

  ///
}
