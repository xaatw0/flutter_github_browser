import 'package:domain/services/http_service.dart';
import 'package:dio/dio.dart';

class DioHttpService implements HttpService {
  final _dio = Dio();

  @override
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    final response = await _dio.get<String>(
      path,
      queryParameters: queryParameters,
      options: Options(responseType: ResponseType.json),
    );

    return response.data.toString();
  }
}