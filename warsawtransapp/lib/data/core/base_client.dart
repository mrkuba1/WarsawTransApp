import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class BABaseClient {
  Future<dynamic> get(Uri uri) async {
    return http.get(uri);
  }

  Future<Response> post(Uri uri, dynamic payload) async {
    return http.post(uri, body: payload);
  }
}
