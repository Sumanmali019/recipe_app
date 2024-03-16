import 'dart:convert';
import 'package:http/http.dart' as http;

class EdamamApiService {
  final String apiKey;
  final String apiUrl = 'https://api.edamam.com/api/recipes/v2';

  EdamamApiService(this.apiKey);

  Future<List<dynamic>> searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse('$apiUrl?type=public&q=$query&app_id=fe9ce935&app_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['hits'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
