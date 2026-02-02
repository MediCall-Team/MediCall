class ServiceProviderReviewsModel {
    final double rate,
    numPepoleRate,
      rateFive,
      rateFour,
      rateThree,
      rateTwo,
      rateOne;
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
}

class ReviewsModel {
  final String image, name, description;
  final double rate;

  ReviewsModel({
    required this.image,
    required this.name,
    required this.description,
    required this.rate,
  });
}
