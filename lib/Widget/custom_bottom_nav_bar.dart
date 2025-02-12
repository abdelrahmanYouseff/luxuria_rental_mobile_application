import 'package:flutter/material.dart';

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
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
    );
  }
}
