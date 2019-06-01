import 'package:kiilib_core/kiilib_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpClientImpl extends KiiHttpClient {
  final client = http.Client();
  final KiiContext context;

  HttpClientImpl(this.context);

  @override
  Future<KiiHttpResponse> sendJson(Method method, String url,
      Map<String, String> headers, Map<String, dynamic> body) async {
    String bodyStr = jsonEncode(body);
    return this.sendText(method, url, headers, bodyStr);
  }

  @override
  Future<KiiHttpResponse> sendText(Method method, String url,
      Map<String, String> headers, String body) async {
    headers["X-Kii-AppID"] = this.context.appID;
    headers["X-Kii-AppKey"] = this.context.appKey;
    http.Response response;
    switch (method) {
      case Method.GET:
        response = await this.client.get(url, headers: headers);
        break;
      case Method.POST:
        response = await this.client.post(url, headers: headers, body: body);
        break;
      case Method.PUT:
        response = await this.client.put(url, headers: headers, body: body);
        break;
      case Method.DELETE:
        response = await this.client.delete(url, headers: headers);
        break;
    }
    return KiiHttpResponse(
        response.statusCode, response.headers, response.body);
  }
}
