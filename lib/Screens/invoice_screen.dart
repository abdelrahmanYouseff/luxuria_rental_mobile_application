import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; 
import 'invoice_details_screen.dart'; // تأكد من استيراد الصفحة الجديدة

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<int> invoiceIds = []; 
  String bookingId = '654321'; 

  @override
  void initState() {
    super.initState();
    _fetchInvoiceIds(); 
  }

  Future<void> _fetchInvoiceIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId != null) {
      final response = await http.get(Uri.parse('https://rentluxuria.com/api/invoices/user/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['invoices'] != null && data['invoices'] is List && data['invoices'].isNotEmpty) {
          setState(() {
            invoiceIds = List<int>.from(data['invoices'].map((invoice) => invoice['id']));
          });
        } else {
          setState(() {
            invoiceIds = []; 
          });
        }
      } else {
        setState(() {
          invoiceIds = []; 
        });
      }
    } else {
      setState(() {
        invoiceIds = []; 
      });
    }
  }

  void _navigateToInvoiceDetails(int invoiceId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoiceDetailsScreen(
          invoiceId: invoiceId.toString(), // تمرير رقم الفاتورة
          // يمكنك تمرير بيانات أخرى إذا لزم الأمر
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Invoices',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: invoiceIds.isEmpty
            ? const Center(child: Text('No invoices found', style: TextStyle(fontSize: 16)))
            : ListView.builder(
                itemCount: invoiceIds.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _navigateToInvoiceDetails(invoiceIds[index]), // التنقل عند الضغط
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Invoice ID:', style: TextStyle(fontSize: 16)),
                          Text(invoiceIds[index].toString(), style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
