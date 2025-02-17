import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Screens/home_screen.dart'; // تأكد من استيراد HomeScreen

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  CustomBottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/home.png',
            width: 24,
            height: 24,
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.bookmark, color: Colors.black),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/profile.png',
            width: 24,
            height: 24,
          ),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/order.png',
            width: 30,
            height: 30,
          ),
          label: 'Orders',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz, color: Colors.black),
          label: 'More',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white, // تغيير لون الخلفية إلى الأبيض
      onTap: (index) {
        if (index == 0) { // إذا كانت الفهرس 0 تعني أن المستخدم اختار الصفحة الرئيسية
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()), // انتقل إلى شاشة الهوم
          );
        } else {
          onTap(index); // تمرير الفهرس لبقية العناصر
        }
      },
      type: BottomNavigationBarType.fixed,
    );
  }
}
