import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';
import 'package:luxuria_rentl_app/Screens/otp-screen-registration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    Future<void> checkPhoneNumber(BuildContext context) async {
      final String phoneNumber = phoneController.text.trim();
      if (phoneNumber.isEmpty) {
        print("رقم الهاتف مطلوب!");
        return;
      }

      final Uri apiUrl = Uri.parse('https://rentluxuria.com/api/check-phone');
      try {
        final response = await http.post(
          apiUrl,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"phone_number": phoneNumber}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['exists']) {
            // حفظ بيانات المستخدم
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);
            await prefs.setString('user_name', data['user']['name']);
            await prefs.setString('user_phone', data['user']['phone_number']);
            await prefs.setString('user_email', data['user']['email_address']);
            await prefs.setString('pickup_city', data['user']['pickup_city']);

            // توجيه المستخدم إلى الصفحة الرئيسية بعد نجاح تسجيل الدخول
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OtpScreen()),
            );
          } else {
            print("رقم الهاتف غير موجود: ${data['message']}");
          }
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OtpScreen()),
            );
        }
      } catch (e) {
        print("فشل الاتصال بالـ API: $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Please enter your phone number",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                onPressed: () => checkPhoneNumber(context),
                child: const Text("Login"),
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
