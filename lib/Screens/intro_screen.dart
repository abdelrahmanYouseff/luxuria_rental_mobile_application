import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // تحديد الخلفية السوداء
      body: Stack(
        children: <Widget>[
          // عرض صورة GIF في الصفحة بالكامل
          Center(
            child: Image.asset(
              'assets/images/intro-page.gif', // ضع ملف الـ GIF في assets
              width: double.infinity, // العرض بالكامل
              height: double.infinity, // الارتفاع بالكامل
              fit: BoxFit.cover, // ملء الشاشة
            ),
          ),
          // طبقة فوق الصورة تحتوي على النص والزّر
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0), // مسافة حول الزر
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // لون الزر
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100), // حجم الزر
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // حواف الزر مستديرة
                  ),
                ),
                onPressed: () {
                  // عند الضغط على الزر، التنقل إلى صفحة الـ Home
                  Navigator.pushReplacementNamed(context, '/home'); // التنقل إلى صفحة الـ Home
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
