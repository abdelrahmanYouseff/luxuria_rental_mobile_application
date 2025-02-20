class Car {
  final String name;
  final double dailyPrice;
  final double weeklyPrice; // إضافة السعر الأسبوعي
  final double monthlyPrice; // إضافة السعر الشهري
  final String model;
  final String imageUrl;
  final String description; 

  Car({
    required this.name,
    required this.dailyPrice,
    required this.weeklyPrice, // إضافة السعر الأسبوعي
    required this.monthlyPrice, // إضافة السعر الشهري
    required this.model,
    required this.imageUrl,
    required this.description
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: json['car_name'] as String,
      dailyPrice: (json['price_daily'] as num).toDouble(),
      weeklyPrice: (json['price_weekly'] as num).toDouble(), // استرجاع السعر الأسبوعي
      monthlyPrice: (json['price_monthly'] as num).toDouble(), // استرجاع السعر الشهري
      model: json['model'] as String,
      imageUrl: 'https://rentluxuria.com/storage/${json['car_picture']}',
      description: json['description'],
    );
  }
}
