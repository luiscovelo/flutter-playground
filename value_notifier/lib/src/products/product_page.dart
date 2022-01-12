import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:value_notifier/src/products/states/product_state.dart';
import 'package:value_notifier/src/products/stores/product_store.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<ProductStore>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<ProductStore>();
    final state = store.value;
    Widget? child;

    if (state is LoadingProductState) {
      child = const Center(child: CircularProgressIndicator());
    }

    if (state is ErrorProductState) {
      child = Center(child: Text(state.message));
    }

    if (state is SuccessProductState) {
      child = ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (_, index) {
          final product = state.products[index];
          return ListTile(
            title: Text(product.title),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      body: child ?? Container(),
    );
  }
}
