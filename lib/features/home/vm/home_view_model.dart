import 'package:flutter/foundation.dart';
import '../domain/models/product.dart';
import '../domain/use_cases/get_products.dart';

class HomeViewModel extends ChangeNotifier {
  final GetProducts getProducts;

  HomeViewModel(this.getProducts);

  final List<Product> _products = [];
  List<Product> get products => _products;

  int _page = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _error;

  static const int _pageSize = 20;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _error = null;
    notifyListeners();
    final result = await getProducts(limit: _pageSize, offset: _page*_pageSize);
    if (result.isSuccess) {
      final newProducts = result.products!;
      products.addAll(newProducts);
      _hasMore = newProducts.length == _pageSize;
    } else {
      _error = result.error;
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _products.clear();
    _page = 0;
    _hasMore = true;
    _error = null;
    notifyListeners();
    loadMore();
  }
}
