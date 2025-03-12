

import 'package:flutter/material.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:luxuria_rentl_app/Screens/checkoutWebView.dart';
class PrePaymentPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String model;
  final String description;
  final String weeklyPrice;
  final String monthlyPrice;
  final String plateNumber;
  final DateTime? pickupDate;
  final TimeOfDay? pickupTime;
  final DateTime? returnDate;
  final TimeOfDay? returnTime;
  

  const PrePaymentPage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.model,
    required this.description,
    required this.weeklyPrice,
    required this.monthlyPrice,
    required this.plateNumber,
    required this.pickupDate,
    required this.pickupTime,
    required this.returnDate,
    required this.returnTime,

  }) : super(key: key);

  @override
  _PrePaymentPageState createState() => _PrePaymentPageState();
}

class _PrePaymentPageState extends State<PrePaymentPage> {
  int? bookingId; // متغير لتخزين قيمة booking_id
  String fullName = '';
  String phoneNumber = '';
  String emailAddress = '';
  String pickupCity = '';
  double totalAmount = 0.0; // Variable to hold the total amount
  int totalDays = 0; // Variable to hold total days
  double depositAmount = 0.0; // Define depositAmount here

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _calculateTotalDays();
    _calculateTotalAmount();
    _loadBookingId(); // تحميل booking_id عند بدء الصفحة // Calculate the total amount based on total days
  }


    Future<void> _loadBookingId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bookingId = prefs.getInt('bookingId'); // استرجاع booking_id
    });
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('user_name') ?? '';
      phoneNumber = prefs.getString('user_phone') ?? '';
      emailAddress = prefs.getString('user_email') ?? '';
      pickupCity = prefs.getString('pickup_city') ?? '';
    });
  }

  void _calculateTotalDays() {
    if (widget.pickupDate != null && widget.returnDate != null) {
      totalDays = widget.returnDate!.difference(widget.pickupDate!).inDays;
    }
  }

  void _calculateTotalAmount() {
    double price = _parsePrice(widget.price);
    double weeklyPrice = _parsePrice(widget.weeklyPrice);
    double monthlyPrice = _parsePrice(widget.monthlyPrice);
    double currentPrice;

    // تحقق من قيمة السعر
    if (price < 399) {
      depositAmount = 1000; // زيادة الديبوزيت بمقدار 1000 إذا كان السعر أقل من 399
    } else {
      depositAmount = 0; // الديبوزيت يكون 0 إذا كان السعر أكبر من 399
    }

    // حساب totalAmount حسب عدد الأيام
    if (totalDays <= 6) {
      totalAmount = (price * totalDays) + depositAmount; // إضافة الديبوزيت إلى totalAmount
    } else if (totalDays >= 7 && totalDays <= 29) {
      currentPrice = weeklyPrice / 7;
      totalAmount = (currentPrice * totalDays) + depositAmount; // إضافة الديبوزيت إلى totalAmount
    } else if (totalDays > 30) {
      currentPrice = monthlyPrice / 30;
      totalAmount = (currentPrice * totalDays) + depositAmount; // إضافة الديبوزيت إلى totalAmount
    }

    // طباعة قيمة الديبوزيت (يمكنك إزالته لاحقًا)
    print("Deposit Amount: $depositAmount");
  }

  double _parsePrice(String priceString) {
    RegExp regExp = RegExp(r'(\d+(\.\d+)?)'); // هذا التعبير العادي يطابق الأرقام بما في ذلك الأرقام العشرية
    Match? match = regExp.firstMatch(priceString);

    if (match != null) {
      return double.parse(match.group(0)!); // تحويل السلسلة المطابقة إلى double
    }
    return 0.0; // قيمة افتراضية أو معالجة الأخطاء
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text("PrePayment")),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                widget.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Book Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildField('Booking ID:', bookingId.toString()),
                  _buildField('Full Name:', fullName),
                  _buildField('Phone Number:', phoneNumber),
                  _buildField('Email Address:', emailAddress),
                  _buildField('Pickup City:', pickupCity),
                  _buildField('Pickup Date:', widget.pickupDate != null
                      ? DateFormat('yyyy-MM-dd').format(widget.pickupDate!)
                      : 'Select Date'),
                  _buildField('Return Date:', widget.returnDate != null
                      ? DateFormat('yyyy-MM-dd').format(widget.returnDate!)
                      : 'Select Date'),
                  _buildField('Car Details:', '${widget.title} ${widget.model}'),
                  _buildField('Total Days:', totalDays.toString()),
                  _buildField('Deposit Amount:', '\ ${depositAmount.toStringAsFixed(2)} AED'), 
                  _buildField('Total Amount:', '\ ${totalAmount.toStringAsFixed(2)} AED'), // عرض المبلغ الإجمالي
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Payment Method',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: 1,
                        onChanged: (value) {},
                      ),
                      Text('Credit / Debit Card'),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset('assets/icons/visa.png', width: 24, height: 24),
                      SizedBox(width: 8),
                      Image.asset('assets/icons/card.png', width: 24, height: 24),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                 onPressed: () async {
                    try {
                      final response = await http.post(
                        Uri.parse('https://rentluxuria.com/api/create-checkout-session'),
                        body: {
                          'total_amount': totalAmount.toString(),
                          'booking_id': bookingId.toString(), 
                        },
                      );

                      if (response.statusCode == 200) {
                        final jsonResponse = json.decode(response.body);
                        
                        final checkoutUrl = jsonResponse['checkout_url'];

                        if (checkoutUrl != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(checkoutUrl: checkoutUrl),
                            ),
                          );
                        } else {
                          print('Error: checkout_url not found in response');
                        }
                      } else {
                        print('Error: ${response.statusCode} ${response.body}');
                      }
                    } catch (e) {
                      print('Exception occurred: $e');
                    }
                  },
                  child: Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: Colors.black,
                  ),
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
      ),    );
  }

  Widget _buildField(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}