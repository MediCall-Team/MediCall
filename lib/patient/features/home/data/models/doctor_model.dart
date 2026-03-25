class DoctorModel {
  final String image, name, specialty;
  double price,rate;
  int id;

  DoctorModel({
    required this.image,
    required this.name,
    required this.specialty,
    required this.rate,
    required this.price,
    required this.id,
  });

  factory DoctorModel.fromJson(json) {
    return DoctorModel(
      id: json["id"],
      name: json["fullName"],
      specialty: json["specialization"],
      rate: json["rating"].toDouble(),
      price: json["consultationPrice"],
      image: json["pictureUrl"],
    );
  }
}
