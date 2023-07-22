import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/user/cart_screen/provider.dart';
import 'package:shop_management/user/cart_screen/widgets/cart_data_widget.dart';
import 'package:shop_management/user/cart_screen/widgets/cart_error_widget.dart';
import 'package:shop_management/user/cart_screen/widgets/cart_loading_widget.dart';
import 'package:shop_management/user/cart_screen/widgets/empty_cart.dart';

//
// class CartView extends ConsumerWidget {
//   const CartView({Key? key}) : super(key: key);

// @override
// Widget build(BuildContext context, WidgetRef ref) {
//   return ref.watch(isCartEmptyProvider).when(
//       data: (data) {
//         // if (!data) {
//         //   return const EmptyCartView();
//         // } else {
//         //   return const NotEmptyCartView();
//         // }
//         return NotEmptyCartView();
//       },
//       // error: (error, stack) => const CartErrorWidget(),
//       error: (error, stack) => Center(child: Text(stack.toString())),
//       loading: () => const CartLoadingWidget());
// }
// @override
// Widget build(BuildContext context, WidgetRef ref) {
//   return ref.watch(isCartEmptyProvider).when(
//       data: (data) {
//         // if (!data) {
//         //   return const EmptyCartView();
//         // } else {
//         //   return const NotEmptyCartView();
//         // }
//         return NotEmptyCartView();
//       },
//       // error: (error, stack) => const CartErrorWidget(),
//       error: (error, stack) => Center(child: Text(stack.toString())),
//       loading: () => const CartLoadingWidget());
// }
// }

class CartVieww extends ConsumerWidget {
  const CartVieww({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(cartItemsProvider).when(
        data: (data) {
          if (data.docs.isEmpty) {
            return const EmptyCartView();
          } else {
            List<ProductModel> products = [];
            for (var element in data.docs) {
              Map<String, dynamic> m = element.data() as Map<String, dynamic>;
              ProductModel product = ProductModel.fromJson(m);
              products.add(product);
            }

            return RefreshIndicator(
                onRefresh: () => refresh(ref),
                child: CartDataWidget(products: products));
          }
        },
        error: (error, stack) => Center(child: Text(stack.toString())),
        loading: () => const CartLoadingWidget());
  }

  Future<void> refresh(WidgetRef ref) async {
    ref.refresh(cartItemsProvider);
  }
}
