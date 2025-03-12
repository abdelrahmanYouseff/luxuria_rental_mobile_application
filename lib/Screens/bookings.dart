import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:luxuria_rentl_app/Widget/booking_card.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<dynamic> bookings = [];
  Map<int, dynamic> carDetails = {};
  bool isLoading = true;
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userIdString = prefs.getString('user_id');
      int? userId = userIdString != null ? int.tryParse(userIdString) : null;

      if (userId == null) {
        setState(() {
          isLoading = false;
        });
        print('⚠️ لا يوجد user_id صالح في Shared Preferences');
        return;
      }

      final response = await http.get(
        Uri.parse('https://rentluxuria.com/api/bookings/user/$userId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('bookings')) {
          List<dynamic> fetchedBookings = data['bookings'];
          setState(() {
            bookings = fetchedBookings;
          });

          await _fetchCarDetails();
        } else {
          print('⚠️ شكل البيانات غير متوقع: $data');
        }
      } else {
        print('❌ فشل في جلب الحجوزات: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ خطأ أثناء جلب الحجوزات: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchCarDetails() async {
    try {
      final response = await http.get(
        Uri.parse('https://rentluxuria.com/api/cars'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == true && responseData.containsKey('data')) {
          List<dynamic> cars = responseData['data'];

          for (var booking in bookings) {
            int carId = booking['car_id'];
            var car = cars.firstWhere(
              (car) => car['id'] == carId,
              orElse: () => null,
            );

            if (car != null) {
              setState(() {
                carDetails[carId] = car;
              });
              print('✅ تم العثور على السيارة: ${car['car_name']} لـ الحجز ${booking['id']}');
            } else {
              print('🚨 لم يتم العثور على السيارة بالـ ID: $carId');
            }
          }
        } else {
          print('⚠️ شكل بيانات السيارات غير متوقع: $responseData');
        }
      } else {
        print('❌ فشل في جلب بيانات السيارات: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ خطأ أثناء جلب بيانات السيارات: $e');
    }
  }

  Future<void> _deleteBooking(int bookingId) async {
    try {
      final response = await http.delete(
        Uri.parse('https://rentluxuria.com/api/bookings/$bookingId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          bookings.removeWhere((booking) => booking['id'] == bookingId);
          carDetails.remove(bookingId); // تأكد من إزالة تفاصيل السيارة أيضًا
        });
        print('✅ تم حذف الحجز بنجاح');
      } else {
        print('❌ فشل في حذف الحجز: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ خطأ أثناء حذف الحجز: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('My Bookings'))),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : bookings.isEmpty
              ? Center(child: Text("There's no Bookings"))
              : ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    var booking = bookings[index];
                    var carId = booking['car_id'];
                    var car = carDetails[carId] ?? {};

                    return Dismissible(
                      key: Key(booking['id'].toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        final confirmDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Confirm Delete'),
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
                          ),
                        );

                        if (confirmDelete == true) {
                          _deleteBooking(booking['id']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("The booking has been deleted")),
                          );
                        } else {
                          // إذا قام المستخدم بالإلغاء، يمكنك إعادة الحجز
                        }
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                     child: BookingCard(
                      carImage: car['car_picture'], 
                      carName: car['car_name'],
                      model: car['model'],
                      total: double.tryParse(booking['total_amount'].toString()) ?? 0.0,
                      pickupDate: booking['pickup_date'],
                      dropoffDate: booking['return_date'],
                      bookingStatus: booking['status'] ?? "غير محدد", // تعيين قيمة افتراضية
                      bookingId: booking['id'],
                    ),

                    );
                  },
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
}
