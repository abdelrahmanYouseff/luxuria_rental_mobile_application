import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Screens/car-details.dart'; // استيراد صفحة التفاصيل

class CarCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final bool showDescription; // خاصية للتحكم في عرض الوصف

  const CarCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    this.showDescription = true, // القيمة الافتراضية هي true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailsScreen(
              imageUrl: imageUrl,
              title: title,
              description: description,
              price: price,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        color: Color(0xFFF9F9F9),
        child: SizedBox(
          height: 190,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 0),
                            if (showDescription) // التحكم في عرض الوصف
                              Text(
                                description,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            SizedBox(height: 20),
                            Text(
                              price,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                    margin: EdgeInsets.only(right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        imageUrl,
                        width: 175,
                        height: 130,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/carDemo.png', // صورة افتراضية عند حدوث خطأ
                            width: 157,
                            height: 130,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('No Deposit', style: TextStyle(fontSize: 12)),
                    Text('Delivery 1 Hour', style: TextStyle(fontSize: 12)),
                    Text('450 KM Free', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
