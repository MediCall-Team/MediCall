// ملف: ReviewsModel.dart
class ReviewModel {
  final int id;
  final String? comment; // في الـ UI بنسميه description
  final double ratingValue; // في الـ UI بنسميه rate
  final String? userName;
  final String? userImage;

  ReviewModel({
    required this.id,
    this.comment,
    required this.ratingValue,
    this.userName,
    this.userImage,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? 0,
      comment: json['comment'] ?? "",
      ratingValue: (json['ratingValue'] ?? 0).toDouble(),
      userName: json['patientName'] ?? "مستخدم", // حسب الـ API
      userImage: json['patientImage'],
    );
  }
}
