class Car {
  final String name;
  final double dailyPrice;
  final String model;
  final String imageUrl; // إضافة رابط الصورة

  Car({
    required this.name,
    required this.dailyPrice,
    required this.model,
    required this.imageUrl, // إضافة إلى الكونستركتور
  });

  factory Car.fromJson(Map<String, dynamic> json) {
  return Car(
    name: json['car_name'] as String,
    dailyPrice: (json['price_daily'] as num).toDouble(),
    model: json['model'] as String,
    imageUrl: 'https://rentluxuria.com/storage/${json['car_picture']}', // تأكد أن الرابط كامل
  );
}

}
