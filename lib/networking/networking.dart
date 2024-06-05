import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  get(String endPoint) async {
    var url = Uri.parse(endPoint);
    var response = await http.get(url);
    var data = returnResponse(response);
    return data;
  }

  Future<http.Response> postHttp({
    required Map<String, dynamic> data,
    required String api,
    // bool token = false,
  }) async {
    final response = await http.post(
      Uri.parse(api),
      body: json.encode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    log(response.statusCode.toString());

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
