import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Widget/carCard.dart'; 
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart'; 
import 'package:luxuria_rentl_app/Screens/economy_screen.dart';
import 'package:luxuria_rentl_app/Screens/luxury_cars.dart';
import 'package:luxuria_rentl_app/Screens/mid_range.dart';
import 'package:luxuria_rentl_app/Screens/vans_screen.dart';

class SportsPage extends StatefulWidget {
  @override
  _SportsPageState createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  int selectedIndex = 0; 

  void onTap(int index) {
    setState(() {
      selectedIndex = index; 
    });
  }

  final List<String> categories = [
    'Luxury',
    'Mid Range',
    'Economy',
    'Vans & Buses',
    'Sports'
  ];

  final List<Map<String, String>> cars = [
    {
      'imageUrl': 'assets/images/carDemo.png', 
      'title': 'Sport Car 1',
      'description': 'Description of Luxury Car 1',
      'price': '100 AED / Daily',
    },
    {
      'imageUrl': 'assets/images/carDemo.png', 
      'title': 'Sport Car 1',
      'description': 'Description of Luxury Car 1',
      'price': '100 AED / Daily',
    },
    {
      'imageUrl': 'assets/images/carDemo.png', 
      'title': 'Sport Car 1',
      'description': 'Description of Luxury Car 1',
      'price': '100 AED / Daily',
    },
    {
      'imageUrl': 'assets/images/carDemo.png', 
      'title': 'Sport Car 1',
      'description': 'Description of Luxury Car 1',
      'price': '100 AED / Daily',
    },
    {
      'imageUrl': 'assets/images/carDemo.png', 
      'title': 'Sport Car 2',
      'description': 'Description of Luxury Car 2',
      'price': '100 AED / Daily',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'View Sports Cars',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
              print('Notifications Icon Pressed');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                     if (category == 'Luxury') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LuxuryCarsPage()), 
                          );
                        } else if (category == 'Mid Range') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MidRangePage()), 
                          );
                        }else if (category == 'Economy') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EconomyPage()), 
                          );
                        }else if (category == 'Vans & Buses') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VansPage()), 
                          );
                        }else if (category == 'Sports') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SportsPage()), 
                          );
                        } else {
                          print('$category selected');
                        }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: category == 'Sports'
                          ? Colors.grey[600]
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      children: [
                        CarCard(
                          imageUrl: cars[index]['imageUrl']!,
                          title: cars[index]['title']!,
                          description: cars[index]['description']!,
                          price: cars[index]['price']!,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onTap,
      ),
    );
  }
}
