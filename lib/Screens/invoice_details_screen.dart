import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final String invoiceId;

  InvoiceDetailsScreen({required this.invoiceId});

  @override
  _InvoiceDetailsScreenState createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  Map<String, dynamic>? invoiceDetails;
  String? customerName;
  String? email;
  String? carName; // لتخزين اسم السيارة
  String? carModel; // لتخزين موديل السيارة
  String? carYear;
  int selectedIndex = 0; // مؤشر العنصر المحدد في شريط التنقل

  @override
  void initState() {
    super.initState();
    _fetchInvoiceDetails(widget.invoiceId);
    _loadUserData(); // استرجاع بيانات المستخدم من Shared Preferences
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerName = prefs.getString('user_name'); // استرجاع اسم المستخدم
      email = prefs.getString('user_email'); // استرجاع البريد الإلكتروني
    });
  }

  Future<void> _fetchInvoiceDetails(String invoiceId) async {
    final response = await http.get(Uri.parse('https://rentluxuria.com/api/invoices/$invoiceId'));

    if (response.statusCode == 200) {
      setState(() {
        invoiceDetails = json.decode(response.body)['invoice']; // تحليل البيانات

        // تحويل القيم إلى double
        invoiceDetails!['total_amount'] = double.tryParse(invoiceDetails!['total_amount']) ?? 0.0;
        invoiceDetails!['security_deposit'] = double.tryParse(invoiceDetails!['security_deposit']) ?? 0.0;

        // تأكد من أن total_days هو عدد صحيح
        invoiceDetails!['total_days'] = int.tryParse(invoiceDetails!['total_days'].toString()) ?? 0;

        // استرجاع car_id من تفاصيل الفاتورة
        int carId = invoiceDetails!['car_id'];
        _fetchCarDetails(carId); // استدعاء دالة لجلب بيانات السيارة
      });
    } else {
      print('Failed to load invoice details');
    }
  }

  Future<void> _fetchCarDetails(int carId) async {
    final response = await http.get(Uri.parse('https://rentluxuria.com/api/cars/$carId'));

    if (response.statusCode == 200) {
      final carData = json.decode(response.body);
      setState(() {
        carName = carData['car']['car_name']; 
        carModel = carData['car']['model']; // تخزين موديل السيارة
        carYear = carData['car']['year'];
      });
    } else {
      print('Failed to load car details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Details #${widget.invoiceId}'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: invoiceDetails == null // التحقق مما إذا تم تحميل البيانات
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice Details',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildInvoiceDetailRow('Invoice Id:', invoiceDetails!['id'].toString()),
                    _buildInvoiceDetailRow('Creation Date:', invoiceDetails!['created_at'].toString()),
                    _buildInvoiceDetailRow('Customer Name:', customerName ?? 'N/A'), 
                    _buildInvoiceDetailRow('Email Address:', email ?? 'N/A'), 
                    _buildInvoiceDetailRow('Total Days:', '${invoiceDetails!['total_days']} Days'),
                    _buildInvoiceDetailRow('Security Deposit:', '${invoiceDetails!['security_deposit']} AED'),

                    // تفاصيل السيارة
                    SizedBox(height: 20),
                    Text(
                      'Details',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildCarDetailsRow(), // استدعاء دالة جديدة لعرض تفاصيل السيارة

                    SizedBox(height: 20),
                    if (invoiceDetails!['items'] != null && invoiceDetails!['items'] is List)
                      _buildItemList(invoiceDetails!['items'])
                    else
                      Text('', style: TextStyle(color: Colors.red)),
                    SizedBox(height: 20),
                    _buildTotalAmountRow(invoiceDetails!['total_amount']),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildInvoiceDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCarDetailsRow() {
    return Container(
      padding: EdgeInsets.all(10.0), // إضافة حواف داخلية
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent, // اللون الخلفي
        borderRadius: BorderRadius.circular(8.0), // زوايا دائرية
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$carName', style: TextStyle(fontSize: 16, color: Colors.white)), // لون النص
          Text('$carModel', style: TextStyle(fontSize: 16, color: Colors.white)), // لون النص
          Text('$carYear', style: TextStyle(fontSize: 16, color: Colors.white)), // لون النص
        ],
      ),
    );
  }

  Widget _buildItemList(List<dynamic> items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final itemName = items[index]['name'] as String; // تحويل القيمة إلى String
        final itemPrice = items[index]['price'] as double; // تحويل القيمة إلى double
        final itemDays = items[index]['days'] as int; // تحويل القيمة إلى int

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(itemName, style: TextStyle(fontSize: 16)),
                    Text('Total Days: $itemDays', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                Text('${itemPrice.toString()} \AED', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalAmountRow(double totalAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total Amount:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text('${totalAmount.toString()} \AED', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
      ],
    );
  }
}
