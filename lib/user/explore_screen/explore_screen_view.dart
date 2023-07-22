import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/user/explore_screen/category_scroll.dart';

import 'explore_card_list.dart';
import 'explore_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/user/explore_screen/provider.dart';
import 'package:shop_management/admin/add_product_screen/search_bar.dart';

class ExploreView extends ConsumerWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final productsList = ref.watch(kproductStreamProvider(ref));
    return SafeArea(
      child: ref.watch(kproductStreamProvider).when(
            data: (data) {
              return RefreshIndicator(
                onRefresh: () => refresh(ref),
                child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CustomSearchBar(),
                        Container(height: 50, child: const CategoryScroll()),
                        (data.docs.isNotEmpty)
                            ? ExploreCardList(data: data)
                            : const Center(
                                child: Text(
                                  'No Products',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                      ],
                    )),
              );
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

  Future<void> refresh(WidgetRef ref) async {
    ref.refresh(kproductStreamProvider);
  }
}
