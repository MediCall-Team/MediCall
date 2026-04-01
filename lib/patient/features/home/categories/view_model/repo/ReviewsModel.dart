class ReviewModel {
  final int id;
  final String name;
  final String? description; // ليطابق review.description في الكارد
  final double rate; // ليطابق review.rate في الكارد
  final String createdAt; // ليطابق review.createdAt في الكارد
  final String? image; // ليطابق review.image في الكارد

  ReviewModel({
    required this.id,
    required this.name,
    this.description,
    required this.rate,
    required this.createdAt,
    this.image,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? 0,
      // نستخدم الـ Null Coalescing لضمان عدم حدوث خطأ إذا اختلف اسم الحقل من السيرفر
      name: json['patientName'] ?? json['userName'] ?? "مريض",
      description: json['comment'] ?? json['description'] ?? "",
      rate: (json['ratingValue'] ?? json['rate'] ?? 0).toDouble(),
      createdAt: json['createdAt'] ?? "",
      image:
          json['patientImageUrl'] ??
          json['patientImage'] ??
          json['image'] ??
          "",
    );
  }
}
