import '../../data/repositories/product_repository.dart';
import '../models/product.dart';


class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call({required int limit, required int offset}) {
    return repository.getProducts(limit: limit, offset: offset);
  }
}
