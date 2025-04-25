import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:todo_api_app/UI_Design/Controller/AuthController.dart';

class Networkresponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? body;
  final String? errorMassage; // original name kept

  Networkresponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMassage = 'Something went wrong',
  });
}

class NetworkClient {
  final Logger _logger = Logger();

  // GET Request
  Future<Networkresponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url.trim());

      _prerequest(url);

      Response response = await get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.token.toString(), // 🔑 Add token here
        },
      );

      final decodeJson = _safeDecode(response.body);

      if (response.statusCode == 200) {
        _PostRequest(url, null, response.statusCode, response.body);
        return Networkresponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodeJson,
        );
      } else {
        _PostRequest(url, null, response.statusCode, response.body);
        return Networkresponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: decodeJson,
        );
      }
    } catch (e) {
      _logger.e(e.toString());
      return Networkresponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }



  // POST Request
  Future<Networkresponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url.trim());
print(AuthController.token);
      _prerequest(url);

      Response response = await post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': '${AuthController.token}',
        },
        body: jsonEncode(body),
      );

      final decodeJson = _safeDecode(response.body);

      if (response.statusCode == 200) {
        _PostRequest(url, body, response.statusCode, response.body);
        return Networkresponse(
            isSuccess: true,
            statusCode: response.statusCode,
            body: decodeJson);
      } else {
        _PostRequest(url, body, response.statusCode, response.body);
        return Networkresponse(
            isSuccess: false,
            statusCode: response.statusCode,
            body: decodeJson);
      }
    } catch (e) {
      _PostRequest(url, body, -1, e.toString());
      return Networkresponse(
          isSuccess: false, statusCode: -1, errorMassage: e.toString());
    }
  }

  void _prerequest(String url) {
    _logger.i('URL: $url');
  }

  void _PostRequest(String url, Map<String, dynamic>? body, int statuscode,
      dynamic? errormassage) {
    _logger.i(
      '''
🔗 URL: $url
📤 Request Body: ${body ?? 'N/A'}
📥 Response/Error: $errormassage
📊 Status Code: $statuscode
''',
    );
  }

  Map<String, dynamic>? _safeDecode(String data) {
    try {
      final jsonData = jsonDecode(data);
      if (jsonData is Map<String, dynamic>) {
        return jsonData;
      }
    } catch (e) {
      _logger.w("❗ JSON Decode Failed: $e");
    }
    return null;
  }
}
