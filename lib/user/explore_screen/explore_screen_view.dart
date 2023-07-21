import 'package:shop_management/models/product/product_model.dart';

import 'explore_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/user/explore_screen/provider.dart';
import 'package:shop_management/admin/add_product_screen/search_bar.dart';

class ExploreView extends ConsumerWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsList = ref.watch(productStreamProvider);
    return SafeArea(
      child: productsList.when(
        data: (data) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomSearchBar(),
                Expanded(
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        // Text(data.docs[index].data().toString());
                        Map<String, dynamic> map =
                            data.docs[index].data() as Map<String, dynamic>;
                        ProductModel product = ProductModel.fromJson(map);
                        return ExploreCard(
                          productModel: product,
                          email: "chayanhjain@gmail.com",
                        );
                      }),
                ),
              ]);
        },
        error: (error, stack) {
          return Text(error.toString());
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
