import 'dart:convert';

import 'package:basicfirebase/common/API.dart';
import 'package:http/http.dart' as http;

class HttpService {

  static Future<Map> get(String token, String url) async {
    final uri = Uri.parse(ENDPOINT + url);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> resData = jsonDecode(response.body);
      return resData;
    }

    throw Exception(response.statusCode);
  }

  static Future<Map> post(String token, String url, Map<String, dynamic> body) async {
    final uri = Uri.parse(ENDPOINT + url);
    final response = await http.post(
      uri,
      headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body)
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resData = jsonDecode(response.body);
      return resData;
    }

    throw Exception(response.statusCode);
  }

  static Future<Map> put(String token, String url, Map<String, dynamic> body) async {
    final uri = Uri.parse(ENDPOINT + url);
    final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body)
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resData = jsonDecode(response.body);
      return resData;
    }

    throw Exception(response.statusCode);
  }

  static Future<Map> delete(String token, String url, Map<String, dynamic> body) async {
    final uri = Uri.parse(ENDPOINT + url);
    final response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body)
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> resData = jsonDecode(response.body);
      return resData;
    }

    throw Exception(response.statusCode);
  }
}