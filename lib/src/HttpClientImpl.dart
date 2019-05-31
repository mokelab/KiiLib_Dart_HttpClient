import 'package:KiiLibCore/KiiLibCore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpClientImpl extends KiiHttpClient {
  final client = http.Client();

  @override
  Future<KiiHttpResponse> sendJson(Method method, String url,
      Map<String, String> headers, Map<String, dynamic> body) async {
    String bodyStr = jsonEncode(body);
    http.Response response;
    switch (method) {
      case Method.GET:
        response = await this.client.get(url, headers: headers);
        break;
      case Method.POST:
        response = await this.client.post(url, headers: headers, body: bodyStr);
        break;
      case Method.PUT:
        response = await this.client.put(url, headers: headers, body: bodyStr);
        break;
      case Method.DELETE:
        response = await this.client.delete(url, headers: headers);
        break;
    }
    return KiiHttpResponse(
        response.statusCode, response.headers, response.body);
  }

  @override
  Future<KiiHttpResponse> sendText(Method method, String url,
      Map<String, String> headers, String body) async {
    return null;
  }
}
