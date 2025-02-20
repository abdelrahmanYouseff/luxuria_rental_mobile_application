import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Widget/carCard.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:luxuria_rentl_app/Services/api_service.dart';
import 'package:luxuria_rentl_app/Models/car_model.dart';
import 'package:luxuria_rentl_app/Screens/luxury_cars.dart';
import 'package:luxuria_rentl_app/Screens/mid_range.dart';
import 'package:luxuria_rentl_app/Screens/economy_screen.dart';
import 'package:luxuria_rentl_app/Screens/sports_screen.dart';
import 'package:luxuria_rentl_app/Screens/vans_screen.dart';

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
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(),
            SizedBox(height: 50),
            _buildSectionTitle('Categories'),
            SizedBox(height: 15),
            _buildCategoryList(),
            SizedBox(height: 30),
            _buildSectionTitle('Promotions'),
            SizedBox(height: 10),
            _buildPromotions(),
            SizedBox(height: 20),
            _buildCarSection('Luxury Cars', ApiService.fetchLuxuryCars()),
            _buildCarSection('Mid Range Cars', ApiService.fetchMidCars()),
            _buildCarSection('Economy Cars', ApiService.fetchEconomyCars()),
            _buildCarSection('Vans & Bus Cars', ApiService.fetchVansCars()),
            _buildCarSection('Sports', ApiService.fetchSportCars()),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
  selectedIndex: _selectedIndex,
  onTap: _onItemTapped, // تأكد أن _onItemTapped تأخذ int كمعامل
),

    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
          onPressed: () => print('Notifications Icon Pressed'),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Good Day,', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(width: 8),
            Image.asset('assets/icons/wave.png', width: 25),
          ],
        ),
        SizedBox(height: 8),
        Text('Experience our luxurious cars today with quick delivery!',
            style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black));
  }

Widget _buildCategoryList() {
  List<Map<String, dynamic>> categories = [
    {'title': 'Luxury', 'page': LuxuryCarsPage()},
    {'title': 'Mid Range', 'page': MidRangePage()},
    {'title': 'Economy', 'page': EconomyPage()},
    {'title': 'Vans & Bus', 'page': VansPage()},
    {'title': 'Sports', 'page': SportsPage()},
  ];

  return Container(
    height: 40,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: categories.map((category) => _categoryButton(category['title'], category['page'])).toList(),
    ),
  );
}


Widget _categoryButton(String title, Widget targetPage) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(title, style: TextStyle(fontSize: 16)),
    ),
  );
}



  Widget _buildPromotions() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset('assets/images/promotions.png', width: double.infinity, fit: BoxFit.cover),
    );
  }

  Widget _buildCarSection(String title, Future<List<Car>> future) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 35),
        _buildSectionTitle(title),
        SizedBox(height: 20),
        _buildCarList(future),
      ],
    );
  }

  Widget _buildCarList(Future<List<Car>> future) {
    return FutureBuilder<List<Car>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No cars available'));
        } else {
          return Container(
            height: 200,
            child: PageView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Car car = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CarCard(
                    imageUrl: car.imageUrl,
                    title: car.name,
                    model: car.model,
                    price: '${car.dailyPrice}',
                    weeklyPrice: '${car.weeklyPrice}',
                    monthlyPrice: '${car.monthlyPrice}',
                    description: car.description,
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
