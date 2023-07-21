import 'package:flutter/material.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/user/explore_screen/product_page.dart';

class ExploreCard extends StatelessWidget {
  final String email;
  final ProductModel productModel;
  const ExploreCard(
      {super.key, required this.productModel, required this.email});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductPage(email: email, product: productModel)));
      },
      child: Column(
        children: [
          const SizedBox(
            height: 200,
            width: 300,
            child: Image(image: AssetImage('lib/images/img1.png')),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: Text(productModel.name ?? '..')),
                Expanded(flex: 1, child: Text(productModel.price.toString())),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
