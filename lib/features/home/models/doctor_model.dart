class DoctorModel {
  final String image, name, specialty, rate, price;
  final bool isActive;

  DoctorModel({
    required this.image,
    required this.name,
    required this.specialty,
    required this.rate,
    required this.price, required this.isActive,
  });
}
