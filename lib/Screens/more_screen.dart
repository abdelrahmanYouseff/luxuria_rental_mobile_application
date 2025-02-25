import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // استيراد الحزمة
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:luxuria_rentl_app/Screens/home_screen.dart'; 

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  // دالة لتشغيل الاتصال
  void _callUs() async {
  const phoneNumber = '+971542700030';
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (await canLaunchUrl(launchUri)) {  // استخدام canLaunchUrl
    await launchUrl(launchUri); // استخدام launchUrl
  } else {
    throw 'Could not launch $launchUri';
  }
}

void _chatWithUs() async {
  const wphoneNumber = '971542700030'; 
  final Uri launchUri = Uri(
    scheme: 'https',
    host: 'wa.me',
    path: wphoneNumber,
  );
  
  if (await canLaunchUrl(launchUri)) {  
    await launchUrl(launchUri); 
  } else {
    throw 'Could not launch $launchUri';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'More', 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), 
            );
          }, 
        ),
        actions: [
          IconButton(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/icons/mingcute_notification-line.png'), 
            ),
            onPressed: () {
              debugPrint('Notifications Icon Pressed');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), 
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                _callUs(); // استدعاء دالة الاتصال
              },
              child: const Text(
                'Call Us',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), 
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                _chatWithUs(); // استدعاء دالة الدردشة عبر واتساب
              },
              child: const Text(
                'Chat With Us',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2, 
        onTap: (index) {
        },
      ),
    );
  }
}
