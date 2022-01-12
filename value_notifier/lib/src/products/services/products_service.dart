import 'package:uno/uno.dart';
import 'package:value_notifier/src/products/model/product_model.dart';

class ProductsService {
  final Uno uno;

  ProductsService(this.uno);

  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await uno.get('https://81db-138-94-55-218.ngrok.io/products');
    final list = response.data as List;
    final products = list.map((e) => ProductModel.fromMap(e)).toList();
    return products;
  }
}
