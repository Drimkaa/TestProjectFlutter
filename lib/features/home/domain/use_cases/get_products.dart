import '../../data/repositories/product_repository.dart';
import '../models/product.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<ProductResult> call({
    required int limit,
    required int offset,
  }) {
    return repository.getProducts(limit: limit, offset: offset);
  }
}
