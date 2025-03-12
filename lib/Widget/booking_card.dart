import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingCard extends StatelessWidget {
  final String carName;
  final String model;
  final double total;
  final String pickupDate;
  final String dropoffDate;
  final String bookingStatus;
  final String carImage;
  final int bookingId; // إضافة متغير لحفظ معرف الحجز

  const BookingCard({
    Key? key,
    required this.carName,
    required this.model,
    required this.total,
    required this.pickupDate,
    required this.dropoffDate,
    required this.bookingStatus,
    required this.carImage,
    required this.bookingId, // إضافة المعامل في المُنشئ
  }) : super(key: key);

  Future<void> deleteBooking(BuildContext context) async {
    final response = await http.delete(
      Uri.parse('https://rentluxuria.com/api/bookings/$bookingId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // إذا تم الحذف بنجاح، يمكنك تحديث واجهة المستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking deleted successfully!')),
      );
    } else {
      // التعامل مع الأخطاء
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete booking.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://rentluxuria.com/storage/$carImage';

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        carName,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text("Model: $model"),
                      Text("Total Price: ${total.toStringAsFixed(2)} AED"),
                      Text("Pickup Date: $pickupDate"),
                      Text("Return Date: $dropoffDate"),
                      Text(
                        "Status: $bookingStatus",
                        style: TextStyle(
                          color: bookingStatus == "Confirmed" ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    width: 150,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Deletion'),
                      content: Text('Are you sure you want to delete this booking?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );

                if (confirmed == true) {
                  await deleteBooking(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
