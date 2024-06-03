import 'dart:convert';

import 'package:basicfirebase/common/API.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HttpService {

  static Future<Map> get(String token, String url) async {
    final uri = Uri.parse(ENDPOINT + url);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode < 400) {
      Map<String, dynamic> resData = jsonDecode(utf8.decode(response.bodyBytes));
      return resData;
    }

    throw HttpServiceException(response);
  }

  static void post(String token, String url, Map<String, dynamic> body) async {
    final uri = Uri.parse(ENDPOINT + url);
    final response = await http.post(
      uri,
      headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body)
    );
    if (response.statusCode >= 400) {
      throw HttpServiceException(response);
    }
  }

  static Future<Map> postAndGet(String token, String url, Map<String, dynamic> body) async {
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
      Map<String, dynamic> resData = jsonDecode(utf8.decode(response.bodyBytes));
      return resData;
    }
    if (response.statusCode == 201) {
      return response.headers;
    }

    throw HttpServiceException(response);
  }

  static void put(String token, String url, Map<String, dynamic> body) async {
    final uri = Uri.parse(ENDPOINT + url);
    final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body)
    );

    if (response.statusCode >= 400) {
      throw HttpServiceException(response);
    }
  }

  static void delete(String token, String url) async {
    final uri = Uri.parse(ENDPOINT + url);
    final response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
    );

    if (response.statusCode >= 400) {
      throw HttpServiceException(response);
    }
  }

  static Future<void> uploadFile(XFile file, String path, String name) async {
    final url = Uri.parse(IMAGE_UPLOAD_ENDPOINT + path);
    final request = http.MultipartRequest('PUT', url);
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: name,
    ));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('File upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('File upload failed: $e');
    }
  }
}

class HttpServiceException implements Exception {
  final http.Response response;

  HttpServiceException(this.response);

  @override
  String toString() {
    return "${response.statusCode}\n${response.body}";
  }
}