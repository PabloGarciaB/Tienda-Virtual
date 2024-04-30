import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://fakestoreapi.com';

  Future<bool> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
