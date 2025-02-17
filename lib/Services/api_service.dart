import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/car_model.dart';

class ApiService {
  static const String baseUrl = 'https://rentluxuria.com/api';

  static Future<List<Car>> fetchLuxuryCars() async {
    return _fetchCars('$baseUrl/luxury');
  }

  static Future<List<Car>> fetchMidCars() async {
    return _fetchCars('$baseUrl/mid');
  }

  static Future<List<Car>> fetchEconomyCars() async {
    return _fetchCars('$baseUrl/economy');
  }

   static Future<List<Car>> fetchSportCars() async {
    return _fetchCars('$baseUrl/sports');
  }

    static Future<List<Car>> fetchVansCars() async {
    return _fetchCars('$baseUrl/vans');
  }

  static Future<List<Car>> _fetchCars(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((carJson) => Car.fromJson(carJson)).toList();
      } else {
        throw Exception('فشل في تحميل البيانات: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }
}
