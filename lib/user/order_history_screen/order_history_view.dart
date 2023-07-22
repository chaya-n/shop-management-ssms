import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/user/order_history_screen/provider.dart';
import 'order_card.dart';

class OrderHistoryView extends ConsumerWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.refresh(orderHistoryProvider);
    return ref.watch(orderHistoryProvider).when(
        data: (data) {
          print('This is data length ${data.length}');
          return RefreshIndicator(
            onRefresh: () => refresh(ref),
            child: Container(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, int index) {
                  List<ProductModel> productsList = data[index];
                  return OrderCard(
                    productsList: productsList,
                  );
                },
              ),
            ),
          );
        },
        error: (error, stack) => Center(
              child: Text(error.toString()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  Future<void> refresh(WidgetRef ref) async {
    ref.refresh(orderHistoryProvider);
  }
}
