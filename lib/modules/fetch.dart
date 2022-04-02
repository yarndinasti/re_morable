import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteService {
  static var client = http.Client();

  static Future<dynamic> getData(String url) async {
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
