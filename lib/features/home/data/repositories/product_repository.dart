import '../../domain/models/product.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductResult {
  final List<Product>? products;
  final String? error;

  const ProductResult.success(this.products) : error = null;
  const ProductResult.failure(this.error) : products = null;

  bool get isSuccess => products != null;
}

class ProductRepository {
  final ProductService service;

  ProductRepository(this.service);

  Future<ProductResult> getProducts({
    required int limit,
    required int offset,
  }) async {
    try {
      final data = await service.fetchProducts(limit: limit, offset: offset);
      final products = data
          .map((json) => ProductModel.fromJson(json))
          .toList();
      return ProductResult.success(products);
    } on NetworkException {
      return const ProductResult.failure(
        'Нет подключения к интернету или сервер недоступен.',
      );
    } on UnknownException catch (e) {
      return ProductResult.failure('Ошибка: ${e.message}');
    } catch (_) {
      return const ProductResult.failure('Неизвестная ошибка при загрузке.');
    }
  }
}
