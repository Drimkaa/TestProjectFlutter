import 'package:dio/dio.dart';

class ProductService {
  final Dio dio;

  ProductService(this.dio);

  Future<List<dynamic>> fetchProducts({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await dio.get(
        'https://fakestoreapi.com/products',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw NetworkException(e);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}

class NetworkException implements Exception {
  final DioException dioException;
  NetworkException(this.dioException);
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}
