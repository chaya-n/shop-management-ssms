import 'package:flutter/material.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/user/explore_screen/quantity_incrementer.dart';

class ProductPage extends StatelessWidget {
  final String email;
  final ProductModel product;
  const ProductPage({super.key, required this.email, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Text(product.description.toString()),
          ),
          const QuantityIncrementer(),
          ElevatedButton(
              onPressed: () {
                FirestoreHandler().getUserFromEmail(email).then((user) {
                  user.cartItems.add(product);
                  print(user.cartItems.length);
                  FirestoreHandler().setCart(user);
                });
              },
              child: const Text('Add to Cart'))
        ],
      ),
    );
  }
}
