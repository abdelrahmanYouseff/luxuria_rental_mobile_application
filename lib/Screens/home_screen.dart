import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Widget/carCard.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:luxuria_rentl_app/Screens/luxury_cars.dart';
import 'package:luxuria_rentl_app/Screens/mid_range.dart';
import 'package:luxuria_rentl_app/Screens/economy_screen.dart';
import 'package:luxuria_rentl_app/Screens/vans_screen.dart';
import 'package:luxuria_rentl_app/Screens/sports_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Home',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/icons/mingcute_notification-line.png'),
            ),
            onPressed: () {
              print('Notifications Icon Pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Good Day,',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(width: 8),
                Image.asset('assets/icons/wave.png', width: 25),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Experience our luxurious cars today with quick delivery!',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 50),

            Text(
              'Categories',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 15),

            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryButton('Luxury'),
                  categoryButton('Mid Range'),
                  categoryButton('Economy'),
                  categoryButton('Vans & Bus'),
                  categoryButton('Sports'),
                ],
              ),
            ),

            SizedBox(height: 30),

            Text(
              'Promotions',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),

            Image.asset(
              'assets/images/promotions.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 20),

            sectionTitle('Luxury Cars'),
            SizedBox(height: 20),
            carSlider(), 

            SizedBox(height: 35),

            sectionTitle('Mid Rang Cars'),
            SizedBox(height: 20),
            carSlider(), 

            SizedBox(height: 20),

            sectionTitle('Economy Cars'),
            SizedBox(height: 20),
            carSlider(), 
            
            SizedBox(height: 20),

            sectionTitle('Vans & Bus Cars'),
            SizedBox(height: 20),
            carSlider(), 

            SizedBox(height: 20),

            sectionTitle('Sports'),
            SizedBox(height: 20),
            carSlider(), 
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          'View All',
          style: TextStyle(fontSize: 14, color: Colors.blue),
        ),
      ],
    );
  }

Widget carSlider() {
  return Container(
    height: 200, // ارتفاع السلايدر
    child: PageView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), 
          child: CarCard(
            imageUrl: 'assets/images/carDemo.png',
            title: 'Luxury Car',
            description: 'Model 1',
            price: '\$99/day',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), 
          child: CarCard(
            imageUrl: 'assets/images/carDemo.png',
            title: 'Luxury Car',
            description: 'Model 2',
            price: '\$99/day',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), 
          child: CarCard(
            imageUrl: 'assets/images/carDemo.png',
            title: 'Luxury Car',
            description: 'Model 3',
            price: '\$99/day',
          ),
        ),
      ],
    ),
  );
}


Widget categoryButton(String text) {
  return GestureDetector(
    onTap: () {
      if (text == 'Luxury') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LuxuryCarsPage()),
        );
      } else if (text == 'Mid Range') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MidRangePage()),
        );
      } else if (text == 'Economy') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EconomyPage()),
        );
      } else if (text == 'Vans & Bus') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VansPage()),
        );
      } else if (text == 'Sports') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SportsPage()),
        );
      }
      
    },
    child: Container(
      width: 100,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
}