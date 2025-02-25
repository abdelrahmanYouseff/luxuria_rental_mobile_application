import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Screens/second-form-screen.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstFormScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String model;
  final String description;
  final String weeklyPrice; 
  final String monthlyPrice; 
  final String plateNumber;

  const FirstFormScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.model,
    required this.description,
    required this.weeklyPrice,
    required this.monthlyPrice, 
    required this.plateNumber,
  }) : super(key: key);

  @override
  _FirstFormScreenState createState() => _FirstFormScreenState();
}

class _FirstFormScreenState extends State<FirstFormScreen> {
  String? selectedCity;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData(); // استدعاء دالة تحميل بيانات المستخدم
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('user_name') ?? ''; // استرجاع اسم المستخدم
    phoneController.text = prefs.getString('user_phone') ?? ''; // استرجاع رقم الهاتف
    emailController.text = prefs.getString('user_email') ?? ''; // استرجاع البريد الإلكتروني
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Form Registration",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "We need few information to start.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedCity,
              hint: Text('Select City'),
              isExpanded: true,
              items: <String>[
                'Dubai',
                'Sharjah',
                'Abu Dhabi',
                'Al Ain',
                'Ajman',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, 
                minimumSize: Size(double.infinity, 50), 
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondFormScreen(
                      imageUrl: widget.imageUrl,
                      title: widget.title,
                      price: widget.price,
                      model: widget.model,
                      description: widget.description,
                      weeklyPrice: widget.weeklyPrice,
                      monthlyPrice: widget.monthlyPrice,
                      plateNumber: widget.plateNumber,
                    ),
                  ),
                );
              },
              child: Text(
                'Continue',
                    style: TextStyle(color: Colors.white), 
                    ),
            ),

          ],
        ),
      ),
       bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
