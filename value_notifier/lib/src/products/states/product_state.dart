import 'package:value_notifier/src/products/model/product_model.dart';

abstract class ProductState {}

class InitialProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class SuccessProductState extends ProductState {
  final List<ProductModel> products;
  SuccessProductState({required this.products});
}

class ErrorProductState extends ProductState {
  final String message;
  ErrorProductState({required this.message});
}
