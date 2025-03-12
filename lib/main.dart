import 'package:flutter/material.dart';
import 'Screens/intro_screen.dart';
import 'Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

// تشغيل التطبيق
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  Stripe.publishableKey = 'sk_test_51QBy7wCMJLG6tciZdK1fbK37VYVb2wdQK9hH2g3Fb4b81S4N2g49OReYDIxUlnZpJsVH6uBaOkgycGIEAyRnxT2N00P2nlUDet';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/home': (context) => HomeScreen(),
      },
      home: SplashScreen(), // تشغيل شاشة السبلاش سكرين أولًا
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    String? token = await getToken();
    
    if (token == null) {
      await loginUser();
      token = await getToken();
    }

    await Future.delayed(Duration(seconds: 3)); // انتظار 3 ثوانٍ

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => token == null ? IntroScreen() : HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/luxuria-logo.png", width: 150), 
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white), 
          ],
        ),
      ),
    );
  }
}

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

    print("✅ Token: $token"); 

    return true;
  } else {
    print('❌ Failed to login: ${response.body}'); 
    return false;
  }
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('nod_token');
}
