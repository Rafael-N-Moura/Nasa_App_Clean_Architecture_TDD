import 'package:nasa_app_clean_architecture_tdd/core/http_client/http_client.dart';
import 'package:http/http.dart' as http;

class HttpImplementation implements HttpClient {
  final client = http.Client();
  @override
  Future<HttpAnswer> get(String url) async {
    final response = await client.get(Uri.parse(url));
    return HttpAnswer(data: response.body, statusCode: response.statusCode);
  }

  @override
  Future<HttpAnswer> post(String url, {required Map<String, dynamic> body}) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
