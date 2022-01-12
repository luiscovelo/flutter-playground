import 'package:flutter/cupertino.dart';
import 'package:value_notifier/src/products/services/products_service.dart';
import 'package:value_notifier/src/products/states/product_state.dart';

class ProductStore extends ValueNotifier<ProductState> {
  final ProductsService service;

  ProductStore(this.service) : super(InitialProductState());

  Future fetchProducts() async {
    value = LoadingProductState();
    try {
      final products = await service.fetchProducts();
      value = SuccessProductState(products: products);
    } catch (e) {
      value = ErrorProductState(message: e.toString());
    }
  }
}
