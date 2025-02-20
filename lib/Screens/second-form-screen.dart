import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';

class SecondFormScreen extends StatefulWidget {
  @override
  _SecondFormScreenState createState() => _SecondFormScreenState();
}

class _SecondFormScreenState extends State<SecondFormScreen> {
  DateTime? selectedPickupDate;
  TimeOfDay? selectedPickupTime;
  DateTime? selectedReturnDate; // إضافة متغير تاريخ العودة
  TimeOfDay? selectedReturnTime; // إضافة متغير وقت العودة

  Future<void> _selectPickupDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedPickupDate = picked;
      });
    }
  }

  Future<void> _selectPickupTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedPickupTime = picked;
      });
    }
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedReturnDate = picked;
      });
    }
  }

  Future<void> _selectReturnTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedReturnTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Booking Form',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/icons/mingcute_notification-line.png',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView( // إضافة Scroll View هنا
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Booking Form \nFor Your \nMercedes Benz E350 2025.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/carDemo.png',
              width: double.infinity,
              height: 210,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pickup Date',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectPickupDate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            selectedPickupDate == null
                                ? 'Select Date'
                                : '${selectedPickupDate!.day}/${selectedPickupDate!.month}/${selectedPickupDate!.year}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectPickupTime(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            selectedPickupTime == null
                                ? 'Select Time'
                                : selectedPickupTime!.format(context),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // فاصل بين تواريخ الحجز
                  Text(
                    'Return Date',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectReturnDate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            selectedReturnDate == null
                                ? 'Select Date'
                                : '${selectedReturnDate!.day}/${selectedReturnDate!.month}/${selectedReturnDate!.year}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectReturnTime(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            selectedReturnTime == null
                                ? 'Select Time'
                                : selectedReturnTime!.format(context),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30), // إضافة مسافة أسفل المحتوى
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  // هنا يمكنك إضافة الوظيفة الخاصة بك عند الضغط على زر Continue
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // لون الزر
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 150),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20), // فاصل بين الزر والمحتوى
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onTap: (index) {},
      ),
    );
  }
}
