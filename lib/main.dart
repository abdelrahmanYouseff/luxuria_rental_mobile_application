
import 'package:flutter/material.dart';
import 'Screens/intro_screen.dart';
import 'Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await getToken(); // استرجاع التوكن المحفوظ

  if (token == null) {
    await loginUser(); // تسجيل الدخول تلقائيًا وحفظ التوكن
    token = await getToken(); // استرجاع التوكن بعد تسجيل الدخول
  }

  runApp(MyApp(initialRoute: token == null ? '/intro' : '/home'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: {
        '/intro': (context) => IntroScreen(),
        '/home': (context) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// ✅ دالة تسجيل الدخول وجلب التوكن
Future<bool> loginUser() async {
  const String url = 'https://luxuria.crs.ae/api/v1/auth/jwt/token';

  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode({
      'username': 'info@rentluxuria.com',
      'password': ')ixLj(CQYSE84MRMqm*&dega'
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    String token = data['token'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nod_token', token);

    print("HeloooooooooooVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV");

    print('✅ Token: $token'); 

    return true;
  } else {
    print('❌ Failed to login: ${response.body}'); 
    return false;
  }
}

// ✅ استرجاع التوكن المحفوظ
Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('nod_token');
}