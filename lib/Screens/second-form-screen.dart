import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // استيراد مكتبة http
import 'package:intl/intl.dart';
import 'dart:convert'; // لاستعمال jsonDecode
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:luxuria_rentl_app/Screens/prepayment.dart';
import 'package:shared_preferences/shared_preferences.dart'; // استيراد مكتبة SharedPreferences

class SecondFormScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String model;
  final String description;
  final String weeklyPrice;
  final String monthlyPrice;
  final String plateNumber;
  final String? pickupDate; // تاريخ الاستلام
  final String? pickupTime; // وقت الاستلام
  final String? returnDate; // تاريخ الإرجاع
  final String? returnTime; // وقت الإرجاع

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
    this.pickupDate,
    this.pickupTime,
    this.returnDate,
    this.returnTime,
  }) : super(key: key);
  
  @override
  _SecondFormScreenState createState() => _SecondFormScreenState();
}

class _SecondFormScreenState extends State<SecondFormScreen> {
  DateTime? selectedPickupDate;
  TimeOfDay? selectedPickupTime;
  DateTime? selectedReturnDate;
  TimeOfDay? selectedReturnTime;

  String? userId; 
  String? userName; // متغير لتخزين اسم المستخدم
  String? userEmail;
  String? userPhone; // متغير لتخزين بريد المستخدم

  @override
  void initState() {
    super.initState();
    _loadUserData(); // تحميل بيانات المستخدم عند بداية الشاشة
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username'); // استرجاع اسم المستخدم
      userEmail = prefs.getString('email'); // استرجاع بريد المستخدم
      userPhone = prefs.getString('user_phone');
      userId = prefs.getString('user_id');

    });
  }

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
        return true; 
      } else {
        print('Car is not available');
        return false;
      }
    } else {
      print('حدث خطأ أثناء التحقق من التوافر: ${response.statusCode}');
      return false; 
    }
  }


String formatTimeOfDay(TimeOfDay time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return '$hours:$minutes:00'; // إضافة ":00" للتنسيق HH:mm:ss
}


Future<void> createBooking(String plateNumber) async {
  final carsResponse = await http.get(Uri.parse('https://rentluxuria.com/api/cars'));

  if (carsResponse.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(carsResponse.body);
    final List<dynamic> cars = responseData['data']; 

    int? carId;
    for (var car in cars) {
      if (car['plate_number'] == plateNumber) {
        carId = car['id']; 
        break; 
      }
    }

    String formatDateTime(DateTime date, TimeOfDay time) {
      final int hour = time.hour;
      final int minute = time.minute;
      
      final dt = DateTime(date.year, date.month, date.day, hour, minute);
      
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);
    }

   if (carId != null) {
  // طباعة القيم للتحقق

  print('Formatted Pickup DateTime: ${formatDateTime(selectedPickupDate!, selectedPickupTime!)}');

  final response = await http.post(
    Uri.parse('https://rentluxuria.com/api/bookings'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'user_id': userId,
      'car_id': carId,
      'pickup_date': (selectedPickupDate != null && selectedPickupTime != null) 
          ? formatDateTime(selectedPickupDate!, selectedPickupTime!) 
          : null,
      'return_date': (selectedReturnDate != null && selectedReturnTime != null) 
          ? formatDateTime(selectedReturnDate!, selectedReturnTime!) 
          : null,
      'status': 'pending',
    }),
  );

   
if (carId != null) {
  final response = await http.post(
    Uri.parse('https://rentluxuria.com/api/bookings'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'user_id': userId,
      'car_id': carId,
      'pickup_date': (selectedPickupDate != null && selectedPickupTime != null) 
          ? formatDateTime(selectedPickupDate!, selectedPickupTime!) 
          : null,
      'return_date': (selectedReturnDate != null && selectedReturnTime != null) 
          ? formatDateTime(selectedReturnDate!, selectedReturnTime!) 
          : null,
      'status': 'pending',
    }),
  );

  // طباعة كود الحالة
  print('Response Status Code: ${response.statusCode}');

  try {
    final responseData = jsonDecode(response.body);
    print('Response Body: $responseData'); // طباعة الرد بالكامل

    if (response.statusCode == 201) {
      final bookingId = responseData['booking_id'];

      // تخزين الـ booking ID
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('bookingId', bookingId);

      print('✅ Booked Successfully!');
      print('Booking ID: $bookingId');
    } else {


      // إذا كان هناك خطأ، طبع تفاصيله
      print('❌ Booking Failed. Error: ${responseData['message'] ?? 'Unknown Error'}');
      print('Formatted Pickup DateTime: ${formatDateTime(selectedPickupDate!, selectedPickupTime!)}');

    }
  } catch (e) {
    print('🚨 Error decoding response: $e');
    print('Response Body (Raw): ${response.body}');
  }
}
    } else {
      print('Plate number not found.');
    }
  } else {
    print('Failed to fetch cars: ${carsResponse.statusCode}');
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
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      if (await checkVehicleAvailability(widget.plateNumber)) {
                        // إذا كانت السيارة متاحة، انتقل إلى صفحة الدفع بعد إنشاء الحجز
                        await createBooking(widget.plateNumber); // إنشاء الحجز
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
                              pickupDate: selectedPickupDate, // تمرير تاريخ الاستلام
                              pickupTime: selectedPickupTime,   // تمرير وقت الاستلام
                              returnDate: selectedReturnDate, // تمرير تاريخ الإرجاع
                              returnTime: selectedReturnTime,    // تمرير وقت الإرجاع
                            ),
                          ),
                        );

                      } else {
                        // عرض رسالة خطأ إذا كانت السيارة غير متاحة
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('The vehicle is not available.')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Continue to Payment',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
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
