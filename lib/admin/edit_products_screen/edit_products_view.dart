import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/admin/edit_products_screen/edit_products_data_view.dart';
import 'package:shop_management/admin/edit_products_screen/provider.dart';
import 'package:shop_management/user/cart_screen/widgets/cart_error_widget.dart';
import 'package:shop_management/user/cart_screen/widgets/cart_loading_widget.dart';

class EditProductsView extends ConsumerWidget {
  const EditProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(providerForAllProductsForAdmin).when(
        data: (data) => EditProductsDataView(data: data),
        error: (error, stack) => const CartErrorWidget(),
        loading: () => const CartLoadingWidget());
  }
}
