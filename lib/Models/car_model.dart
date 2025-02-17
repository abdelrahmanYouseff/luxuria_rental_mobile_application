class Car {
  final String name;
  final double dailyPrice;
  final String model;
  final String imageUrl; 

  Car({
    required this.name,
    required this.dailyPrice,
    required this.model,
    required this.imageUrl, 
  });

  factory Car.fromJson(Map<String, dynamic> json) {
  return Car(
    name: json['car_name'] as String,
    dailyPrice: (json['price_daily'] as num).toDouble(),
    model: json['model'] as String,
    imageUrl: 'https://rentluxuria.com/storage/${json['car_picture']}', 
  );
}

}
