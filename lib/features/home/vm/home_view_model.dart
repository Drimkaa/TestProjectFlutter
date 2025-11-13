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

  static const int _pageSize = 20;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newProducts = await getProducts(limit: _pageSize, offset: _page * _pageSize);
      if (newProducts.length < _pageSize) {
        _hasMore = false;
      }
      _products.addAll(newProducts);
      _page++;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _products.clear();
    _page = 0;
    _hasMore = true;
    notifyListeners();
    loadMore();
  }
}
