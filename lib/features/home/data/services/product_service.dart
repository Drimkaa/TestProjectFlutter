import 'package:dio/dio.dart';

class ProductService {
  final Dio dio;

  ProductService(this.dio);

  Future<List<dynamic>> fetchProducts({required int limit, required int offset}) async {

    final response = await dio.get('https://fakestoreapi.com/products', queryParameters: {
      'limit': limit,
      'offset': offset,
    });

    return response.data as List<dynamic>;
  }
}
