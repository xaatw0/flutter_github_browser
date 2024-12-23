abstract interface class HttpService {
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      });
}