class ServiceProviderReviewsModel {
  final double rate;
  final int numPepoleRate, rateFive, rateFour, rateThree, rateTwo, rateOne;
  final List<ReviewsModel> reviewsList;

  ServiceProviderReviewsModel({
    required this.rate,
    required this.numPepoleRate,
    required this.rateFive,
    required this.rateFour,
    required this.rateThree,
    required this.rateTwo,
    required this.rateOne,
    required this.reviewsList,
  });

  factory ServiceProviderReviewsModel.fromJson(Map<String, dynamic> json) {
    final starSummary = json["starSummary"] ?? {};

    return ServiceProviderReviewsModel(
      rate: (json["averageRating"] ?? 0).toDouble(),
      numPepoleRate: (json["totalReviewsCount"] ?? 0),

      rateFive: (starSummary["5"] ?? 0),
      rateFour: (starSummary["4"] ?? 0),
      rateThree: (starSummary["3"] ?? 0),
      rateTwo: (starSummary["2"] ?? 0),
      rateOne: (starSummary["1"] ?? 0),

      // ✅ أهم جزء
      reviewsList:
          (json["recentReviews"] as List?)
              ?.map((e) => ReviewsModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ReviewsModel {
  final String image, name, createdAt;
  final String? description;
  final double rate;

  ReviewsModel({
    required this.image,
    required this.name,
    required this.description,
    required this.rate,
    required this.createdAt,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      image: json["patientImageUrl"] ?? "",
      name: json["patientName"] ?? "",
      description: json["comment"] ?? "",
      rate: (json["ratingValue"] ?? 0).toDouble(),
      createdAt: json["createdAt"] ?? "",
    );
  }
}
