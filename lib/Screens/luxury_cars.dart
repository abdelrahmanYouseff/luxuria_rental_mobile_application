import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Models/car_model.dart';
import 'package:luxuria_rentl_app/Widget/carCard.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:luxuria_rentl_app/Services/api_service.dart';
import 'package:luxuria_rentl_app/Screens/car-details.dart'; // تأكد من استيراد CarDetailsScreen

class LuxuryCarsPage extends StatefulWidget {
  const LuxuryCarsPage({Key? key}) : super(key: key);

  @override
  _LuxuryCarsPageState createState() => _LuxuryCarsPageState();
}

class _LuxuryCarsPageState extends State<LuxuryCarsPage> {
  int selectedIndex = 0;
  late Future<List<Car>> futureCars;

  @override
  void initState() {
    super.initState();
    futureCars = ApiService.fetchLuxuryCars(); 
  }

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'View Luxury Cars',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
      body: FutureBuilder<List<Car>>(
        future: futureCars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Failed to load cars. Please try again later.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No cars available.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          final cars = snapshot.data!;
          return ListView.builder(
            itemCount: cars.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              return GestureDetector( // استخدم GestureDetector للاستجابة للضغط
                onTap: () {
                  // توجيه المستخدم إلى صفحة تفاصيل السيارة مع البيانات
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarDetailsScreen(
                        imageUrl: cars[index].imageUrl,
                        title: cars[index].name,
                        price: '${cars[index].dailyPrice}',
                        model: cars[index].model,
                        weeklyPrice: '${cars[index].weeklyPrice}',
                        monthlyPrice: '${cars[index].monthlyPrice}',
                        description: cars[index].description,
                        plateNumber: cars[index].plate_number,
                      ),
                    ),
                  );
                },
                child: CarCard(
                  imageUrl: cars[index].imageUrl,
                  title: cars[index].name,
                  model: cars[index].model,
                  price: '${cars[index].dailyPrice} AED',
                  weeklyPrice: '${cars[index].weeklyPrice}',
                  monthlyPrice: '${cars[index].monthlyPrice}',
                  description: cars[index].description,
                  plateNumber: cars[index].plate_number,


                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onTap,
      ),
    );
  }
}
