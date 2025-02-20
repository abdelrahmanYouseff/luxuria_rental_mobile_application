import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart'; 
import 'package:luxuria_rentl_app/Screens/first-form-screen.dart'; // تأكد من استيراد صفحة FirstFormScreen

class CarDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String model;
  final String description;
  final String weeklyPrice; // السعر الأسبوعي
  final String monthlyPrice; // السعر الشهري

  const CarDetailsScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.model,
    required this.description,
    required this.weeklyPrice, // إضافة السعر الأسبوعي
    required this.monthlyPrice,// إضافة السعر الشهري
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Car Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error));
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1),
            Text(
              model,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Text(
                  price,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                Text(
                  " AED",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: LabelWidget(label: "Daily", description: "$price AED",)),
                SizedBox(width: 10),
                Expanded(child: LabelWidget(label: "Weekly", description: "$weeklyPrice AED")),
                SizedBox(width: 10),
                Expanded(child: LabelWidget(label: "Monthly", description: "$monthlyPrice AED")),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // الانتقال إلى صفحة FirstFormScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstFormScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 145),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Book Now',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  final String label;
  final String? description;

  const LabelWidget({Key? key, required this.label, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          if (description != null)
            Text(
              description!,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
        ],
      ),
    );
  }
}
