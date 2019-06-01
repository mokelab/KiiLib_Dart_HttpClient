import 'package:test/test.dart';
import 'package:kiilib_core/kiilib_core.dart';
import 'package:kiilib_http_client/kiilib_http_client.dart';
import 'dart:convert';

void main() {
  test('send POST request', () async {
    HttpClientImpl client = HttpClientImpl();
    var result = await client.sendJson(
        Method.POST,
        'https://gae-echoserver.appspot.com',
        {"Content-Type": "application/json"},
        {"a": "b"});
    expect(result.status, 200);
    var json = jsonDecode(result.body) as Map<String, dynamic>;
    expect(json.length, 4);

    var url = json["url"];
    var body = jsonDecode(json["body"]) as Map<String, dynamic>;
    expect(url, "/");
    expect(json["header"]["Content-Type"], "application/json; charset=utf-8");
    expect(json["method"], "POST");
    expect(body["a"], "b");
  });
}
