import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Screens/home_screen.dart';
import 'package:luxuria_rentl_app/Screens/more_screen.dart';
import 'package:luxuria_rentl_app/Screens/offers_screen.dart';
import 'package:luxuria_rentl_app/Screens/profile_screen.dart'; // تأكد من استيراد ProfileScreen

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
          label: 'Offers',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz, color: Colors.black),
          label: 'More',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white, 
      onTap: (index) {
        if (index == 0) { 
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()), 
          );
        } else if (index == 2) { // إذا كانت الفهرس 2 تعني أن المستخدم اختار "Profile"
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()), // الانتقال إلى صفحة الملف الشخصي
          );
        }else if (index == 4) { // إذا كانت الفهرس 2 تعني أن المستخدم اختار "Profile"
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MoreScreen()), // الانتقال إلى صفحة الملف الشخصي
          );
        } else if (index == 3) { // إذا كانت الفهرس 2 تعني أن المستخدم اختار "Profile"
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OfferScreen()), // الانتقال إلى صفحة الملف الشخصي
          );
        } else {
          onTap(index); 
        }
      },
      type: BottomNavigationBarType.fixed,
    );
  }
}
