import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Screens/home_screen.dart'; // تأكد من استيراد HomeScreen
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart'; 
import 'package:luxuria_rentl_app/Screens/first-form-screen.dart';


class CarDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String description;

  const CarDetailsScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
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
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // أضف هنا الإجراء عند الضغط على الإشعارات
            },
          ),
        ],
      ),
      body: SingleChildScrollView(  // جعل الصفحة قابلة للتمرير
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
                    return Center(child: Icon(Icons.error)); // Display an error icon if the image fails to load
                  },
                ),
              ),

            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              price,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(child: LabelWidget(label: "450 KM Free")),
                SizedBox(width: 10),
                Expanded(child: LabelWidget(label: "No Deposit")),
                SizedBox(width: 10),
                Expanded(child: LabelWidget(label: "Free Delivery")),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: LabelWidget(label: "Daily", description: "\500 AED", fontSize: 12,)),
                SizedBox(width: 10),
                Expanded(child: LabelWidget(label: "Weekly", description: "\1500 AED",  fontSize: 12,)),
                SizedBox(width: 10),
                Expanded(child: LabelWidget(label: "Monthly", description: "\1200 AED", fontSize: 12,)),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Description",  // عنوان قسم الوصف
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              description,  // النص الوصفي الذي يتم تمريره من المتغير
              style: TextStyle(fontSize: 14, color: Colors.black54), // تنسيق النص
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // الانتقال إلى صفحة first-form-screen.dart عند الضغط على الزر
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstFormScreen()), // استبدل FirstFormScreen بالصفحة التي تريد الانتقال إليها
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),  
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,  
              children: [
                Text(
                  "Need Assistance?",  
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/whatsapp.png', width: 30, height: 30),  
                      onPressed: () {
                        
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.phone, color: Colors.black),
                      onPressed: () {
                        
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0, // حدد الفهرس الحالي حسب الحاجة
        onTap: (index) {
          // قم بإضافة الإجراءات هنا عند الضغط على أي عنصر في شريط التنقل السفلي
        },
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  final String label;
  final String? description; // نص إضافي (اختياري)
  final double? fontSize; // إضافة خاصية fontSize

  const LabelWidget({Key? key, required this.label, this.description, this.fontSize}) : super(key: key);

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
              style: TextStyle(fontSize: fontSize ?? 12, color: Colors.black54), // استخدام حجم الخط المحدد أو الافتراضي
            ),
        ],
      ),
    );
  }
}
