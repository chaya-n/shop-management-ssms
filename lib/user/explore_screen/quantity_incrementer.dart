import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/shared_widgets/colours.dart';
import 'package:shop_management/user/explore_screen/provider.dart';

import '../../shared_widgets/snackbars.dart';

class QuantityIncrementer extends StatefulWidget {
  final ProductModel product;
  const QuantityIncrementer({super.key, required this.product});

  @override
  State<QuantityIncrementer> createState() => _QuantityIncrementerState();
}

class _QuantityIncrementerState extends State<QuantityIncrementer> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: CustomColours.primaryBlack,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    if (quantity != 0) {
                      quantity--;
                    }
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 28,
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white),
                child: Text(
                  '$quantity',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              InkWell(
                  onTap: () {
                    quantity++;
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  )),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColours.secondaryColour),
              onPressed: () {
                FirestoreHandler().getCurrentUser().then((user) {
                  widget.product.quantity = quantity;
                  if (quantity != 0) {
                    user.cartItems.add(widget.product);
                    try {
                      FirestoreHandler().setCart(user).then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(CustomSnackBars.successSnackBar);
                        Navigator.of(context).pop();
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(CustomSnackBars.failureSnackBar);
                    }
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(CustomSnackBars.zeroQuantitySnackbar);
                  }
                });
              },
              child: const Text('Add to Cart'))
        ],
      ),
    );
  }
}
