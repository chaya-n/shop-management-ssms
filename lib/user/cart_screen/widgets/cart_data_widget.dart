import 'package:flutter/material.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/shared_widgets/colours.dart';
import 'package:shop_management/shared_widgets/snackbars.dart';
import 'package:shop_management/user/cart_screen/widgets/cart_card.dart';
import 'package:shop_management/user/explore_screen/explore_screen_card.dart';

class CartDataWidget extends StatelessWidget {
  final List<ProductModel> products;
  const CartDataWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return CartCard(productModel: products[index]);
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColours.secondaryColour),
              onPressed: () {
                try {
                  FirestoreHandler().emptyCart().then((value) =>
                      ScaffoldMessenger.of(context)
                          .showSnackBar(CustomSnackBars.successSnackBar));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(CustomSnackBars.failureSnackBar);
                }
              },
              child: const Text('Empty Cart')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColours.secondaryColour),
              onPressed: () {
                try {
                  FirestoreHandler().placeOrder().then((value) =>
                      ScaffoldMessenger.of(context)
                          .showSnackBar(CustomSnackBars.successSnackBar));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(CustomSnackBars.failureSnackBar);
                }
              },
              child: const Text('Place Order')),
        ],
      )
    ]);
  }
}
