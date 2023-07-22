import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/admin/edit_products_screen/edit_product_card.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/user/explore_screen/explore_screen_card.dart';

class EditProductsDataView extends StatelessWidget {
  final QuerySnapshot data;
  const EditProductsDataView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: data.docs.length,
        itemBuilder: (context, index) {
          // Text(data.docs[index].data().toString());
          print(data.docs.length);
          Map<String, dynamic> map =
              data.docs[index].data() as Map<String, dynamic>;
          ProductModel product = ProductModel.fromJson(map);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: EditProductCard(
              productModel: product,
            ),
          );
        });
  }
}
