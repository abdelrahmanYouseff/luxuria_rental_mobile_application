import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Screens/home_screen.dart';
import 'package:luxuria_rentl_app/Screens/more_screen.dart';
import 'package:luxuria_rentl_app/Screens/offers_screen.dart';
import 'package:luxuria_rentl_app/Screens/profile_screen.dart';
import 'package:luxuria_rentl_app/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  CustomBottomNavBar({required this.selectedIndex, required this.onTap});

  Future<bool> _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  void _navigateToScreen(BuildContext context, int index) async {
    if (index == 2) { // عند الضغط على البروفايل
      bool isLoggedIn = await _isLoggedIn();
      if (!isLoggedIn) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        ).then((value) {
          // بعد تسجيل الدخول، عد إلى البروفايل
          if (value == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        });
        return;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        return;
      }
    }

    // التنقل بين الصفحات الأخرى
    Widget screen;
    switch (index) {
      case 0:
        screen = HomeScreen();
        break;
      case 3:
        screen = OfferScreen();
        break;
      case 4:
        screen = MoreScreen();
        break;
      default:
        onTap(index);
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/home.png', width: 24, height: 24),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.bookmark, color: Colors.black),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/profile.png', width: 24, height: 24),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/order.png', width: 30, height: 30),
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
      onTap: (index) => _navigateToScreen(context, index),
      type: BottomNavigationBarType.fixed,
    );
  }
}
