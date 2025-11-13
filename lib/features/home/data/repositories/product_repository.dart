import '../../domain/models/product.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductRepository {
  final ProductService service;

  ProductRepository(this.service);

  @override
  Future<List<Product>> getProducts({required int limit, required int offset}) async {
    final data = await service.fetchProducts(limit: limit, offset: offset);
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
