import 'package:flutter/material.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/shared_widgets/colours.dart';
import 'package:shop_management/user/explore_screen/product_page.dart';

class CartCard extends StatelessWidget {
  final ProductModel productModel;
  const CartCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(product: productModel)));
      },
      child: Card(
        color: CustomColours.secondaryColour,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Image(image: AssetImage('lib/images/img1.png')),
                )),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productModel.name ?? '..',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '₹  ${productModel.price}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'x  ${productModel.quantity}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
