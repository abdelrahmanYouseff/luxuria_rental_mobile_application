import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // استيراد مكتبة http
import 'dart:convert'; // لاستعمال jsonDecode
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:luxuria_rentl_app/Screens/prepayment.dart';

class SecondFormScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String model;
  final String description;
  final String weeklyPrice; 
  final String monthlyPrice; 
  final String plateNumber;

  const SecondFormScreen({
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
  _SecondFormScreenState createState() => _SecondFormScreenState();
}

class _SecondFormScreenState extends State<SecondFormScreen> {
  DateTime? selectedPickupDate;
  TimeOfDay? selectedPickupTime;
  DateTime? selectedReturnDate;
  TimeOfDay? selectedReturnTime;

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

Future<bool> checkVehicleAvailability(String plateNumber) async {
  final response = await http.post(
    Uri.parse('https://rentluxuria.com/api/check-vehicle-availability'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'plate_number': plateNumber}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == true && data['message'] == 'Vehicle is available') {
      print('Car is Available');
      return true; // السيارة متاحة
    } else {
      print('Car is not available');
      return false; // السيارة غير متاحة
    }
  } else {
    print('حدث خطأ أثناء التحقق من التوافر: ${response.statusCode}');
    return false; // في حالة حدوث خطأ
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Booking Form For Your \n${widget.title} ${widget.model}.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              widget.imageUrl,
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
                  SizedBox(height: 20),
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
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
               onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Center(child: CircularProgressIndicator());
                },
              );

              // تحقق من توافر السيارة
              bool isAvailable = await checkVehicleAvailability(widget.plateNumber);

              // إغلاق الحوار بعد انتهاء التحقق
              Navigator.of(context).pop();

              // إذا كانت السيارة متاحة، انتقل إلى صفحة الدفع
              if (isAvailable) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => PrePaymentPage(
                    imageUrl: widget.imageUrl,
                    title: widget.title,
                    price: widget.price,
                    model: widget.model,
                    description: widget.description,
                    weeklyPrice: widget.weeklyPrice,
                    monthlyPrice: widget.monthlyPrice,
                    plateNumber: widget.plateNumber,
                    pickupDate: selectedPickupDate,
                    pickupTime: selectedPickupTime,
                    returnDate: selectedReturnDate,
                    returnTime: selectedReturnTime,
                  )
                ));
              } else {
                // يمكنك إظهار رسالة للمستخدم عن عدم توفر السيارة هنا
                print('Car is not available');
              }
            },


                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 135),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20), 
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
