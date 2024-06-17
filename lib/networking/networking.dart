import 'dart:convert';
import 'dart:developer';
import 'package:api_withgetx/utills/api_urls.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /// For GET request
  Future<http.Response> getHttp(
      {required String api, bool token = false}) async {
    final url = ApiUrls.baseUrl + api;
    log(url, name: 'getHttp');

    final response = await http
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    log(response.statusCode.toString());

    return response;
  }

  /// For Post Request
  Future<http.Response> postHttp({
    required Map<String, dynamic> data,
    required String api,
    // bool token = false,
  }) async {
    final url = ApiUrls.baseUrl1 + api;
    log(url, name: 'postHttp');
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    log(response.statusCode.toString());

    return response;
  }

  Future<http.Response> deleteHttp({
    required String api,
    bool token = false,
  }) async {
    final url = ApiUrls.baseUrl + api;
    log(url, name: 'deleteHttp');

    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    return response;
  }

  put(String endPoint, var body) async {
    var url = Uri.parse(endPoint);
    var response = await http.put(url, body: body);
    var data = returnResponse(response);
    return data;
  }

  returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      default:
        throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
