class ServiceProviderReviewsModel {
  final double rate;
  final double numPepoleRate;
  final double rateFive, rateFour, rateThree, rateTwo, rateOne;
  final int serviceProviderId;
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
    required this.serviceProviderId,
  });

  // factory لتحويل البيانات الكبيرة اللي بتيجي في أول مرة
  factory ServiceProviderReviewsModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderReviewsModel(
      serviceProviderId: json['serviceProviderId'] ?? 0,
      rate: (json['rate'] ?? 0).toDouble(),
      numPepoleRate: (json['numPepoleRate'] ?? 0).toDouble(),
      rateFive: (json['rateFive'] ?? 0).toDouble(),
      rateFour: (json['rateFour'] ?? 0).toDouble(),
      rateThree: (json['rateThree'] ?? 0).toDouble(),
      rateTwo: (json['rateTwo'] ?? 0).toDouble(),
      rateOne: (json['rateOne'] ?? 0).toDouble(),
      reviewsList: (json['reviewsList'] as List? ?? [])
          .map((e) => ReviewsModel.fromJson(e))
          .toList(),
    );
  }

 // int get serviceProviderId => null;
}

class ReviewsModel {
  final String image;
  final String name;
  final String description; // اللي هو الـ Comment في الـ API
  final double rate;

  ReviewsModel({
    required this.image,
    required this.name,
    required this.description,
    required this.rate,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      // تأكدي من مسميات الحقول في الـ API (لو اسمها comment غيري description لـ comment)
      image: json['image'] ?? "",
      name: json['userName'] ?? json['name'] ?? "مستخدم مجهول",
      description: json['comment'] ?? json['description'] ?? "",
      rate: (json['ratingValue'] ?? json['rate'] ?? 0).toDouble(),
    );
  }
}
