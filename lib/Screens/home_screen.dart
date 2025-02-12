import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Widget/carCard.dart'; // تأكد من صحة المسار
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart'; // تأكد من المسار الصحيح

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> categories = [
    'Luxury',
    'Mid Range',
    'Economy',
    'Buses & Vans',
    'Sports',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // تغيير خلفية الصفحة إلى الأبيض
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                Image.asset(
                  'assets/icons/wave.png',
                  width: 25,
                )
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Experience our luxurious cars today with quick delivery!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Choose Your Rental!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            // سلايدر للأزرار
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        print('$category selected');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
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
            SizedBox(height: 30), // مسافة قبل قسم الترويج
            
            // عنوان الترويج
            Text(
              'Promotions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),

            // صورة الترويج
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/promotions.png',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),

            // نص Luxury Cars و View All
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Luxury Cars',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('View All Pressed');
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            // عرض كارد السيارة
            CarCard(
              imageUrl: 'assets/images/carDemo.png', // ضع مسار الصورة هنا
              title: 'Luxury Car 1',
              description: 'Luxury',
              price: '\150 AED / Daily',
            ),
            SizedBox(height: 15), // مسافة بين الكروت
            CarCard(
              imageUrl: 'assets/images/carDemo.png', // ضع مسار الصورة هنا
              title: 'Luxury Car 2',
              description: 'Experience the best in luxury.',
              price: '\$200/day',
            ),
            SizedBox(height: 15), // مسافة بين الكروت
            CarCard(
              imageUrl: 'assets/images/carDemo.png', // ضع مسار الصورة هنا
              title: 'Luxury Car 2',
              description: 'Experience the best in luxury.',
              price: '\$200/day',
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
