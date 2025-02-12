import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;

  const CarCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      color: Color(0xFFF9F9F9), // تغيير اللون هنا
      child: SizedBox(
        height: 190, // زيادة ارتفاع الكارد
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // النصوص على اليسار
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
                  // الصورة على اليمين ومحركة قليلًا لليسار
                  Container(
                    margin: EdgeInsets.only(right: 15), // تحريك الصورة قليلاً لليسار
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        imageUrl,
                        width: 157,
                        height: 130, // تثبيت ارتفاع الصورة
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // النصوص الثلاثة في الأسفل تحت الصورة
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
    );
  }
}
