import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:luxuria_rentl_app/Screens/home_screen.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile', 
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
                debugPrint('Personal Information pressed');
              },
              child: const Text(
                'Personal Information',
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
                debugPrint('My Bookings pressed');
              },
              child: const Text(
                'My Bookings',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), 
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                debugPrint('Sign Out pressed');
              },
              child: const Text(
                'Sign Out',
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
