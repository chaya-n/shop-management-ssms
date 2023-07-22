import 'package:flutter/material.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/shared_widgets/colours.dart';
import 'package:shop_management/user/explore_screen/quantity_incrementer.dart';

class ProductPage extends StatelessWidget {
  final ProductModel product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.name.toString()),
        backgroundColor: Color.fromARGB(255, 25, 30, 30),
      ),
      backgroundColor: CustomColours.primaryBlack,
      body: Stack(
        children: [
          Image.asset('lib/images/img1.png'),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text(
                        product.name.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Center(
                      child: Text(
                        product.description.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
                QuantityIncrementer(
                  product: product,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
