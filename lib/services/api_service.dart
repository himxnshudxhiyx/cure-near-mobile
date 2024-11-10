import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts/";

  Future<List<Map<String, dynamic>>> fetchData() async {
    var startTime = DateTime.now().millisecondsSinceEpoch;
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var endTime = DateTime.now().millisecondsSinceEpoch;
      log('API Function Fetch Time -> ${endTime - startTime} ms');
      log('Response -> ${response.body}');
      List<dynamic> jsonData = json.decode(response.body);  // Decode response as a list of dynamic objects
      return jsonData.cast<Map<String, dynamic>>();  // Cast it to a List<Map<String, dynamic>>
    } else {
      throw Exception("Failed to load data");
    }
  }
}


