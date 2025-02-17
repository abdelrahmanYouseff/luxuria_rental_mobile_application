import 'package:flutter/material.dart';

class BookingsScreen extends StatelessWidget {
  final List<Map<String, String>> bookings = [
    {
      'carModel': 'Luxury Car 1',
      'bookingDate': '2025-02-12',
      'price': '\150 AED',
    },
    {
      'carModel': 'Sports Car 2',
      'bookingDate': '2025-02-15',
      'price': '\200 AED',
    },
    {
      'carModel': 'Economy Car 3',
      'bookingDate': '2025-02-18',
      'price': '\100 AED',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Car Model: ${bookings[index]['carModel']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Booking Date: ${bookings[index]['bookingDate']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Price: ${bookings[index]['price']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
