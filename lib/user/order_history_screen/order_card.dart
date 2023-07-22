import 'package:flutter/material.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/shared_widgets/colours.dart';

class OrderCard extends StatelessWidget {
  final List<ProductModel> productsList;
  const OrderCard({super.key, required this.productsList});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      color: CustomColours.primaryBrown,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 6,
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    'Quantity',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ))
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                double totalPrice = (productsList[index].quantity ?? 0) *
                    (productsList[index].price ?? 0);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 6, child: Text(productsList[index].name ?? 'NA')),
                    Expanded(
                        flex: 1,
                        child: Text('${productsList[index].quantity}')),
                    Expanded(flex: 1, child: Text('₹ $totalPrice')),
                  ],
                );
              }),
        ]),
      ),
    );
  }
}
