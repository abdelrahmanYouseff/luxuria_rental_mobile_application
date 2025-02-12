import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // تحديد الخلفية السوداء
      body: Stack(
        children: <Widget>[
          // الصورة التي سيتم تصغيرها وتوسيطها في منتصف الشاشة
          Align(
            alignment: Alignment.center, // لضمان أن الصورة في منتصف الشاشة
            child: Image.asset(
              'assets/images/luxuria-logo.jpg', // مسار الصورة في مجلد assets
              width: 200,  // تحديد العرض
              height: 200, // تحديد الارتفاع
              fit: BoxFit.contain, // الحفاظ على نسبة العرض إلى الارتفاع
            ),
          ),
          // طبقة فوق الصورة تحتوي على النص والزّر
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0), // مسافة حول الزر
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // لون الزر
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
