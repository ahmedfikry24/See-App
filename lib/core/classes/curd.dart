import 'dart:convert';
import 'package:http/http.dart' as http;

class Crud {
  Future<Map<String, dynamic>?> getData(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> responsebody = jsonDecode(response.body);
      return responsebody;
    }
  }
}
