import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/user/cart_screen/provider.dart';

class NotEmptyCartView extends ConsumerWidget {
  const NotEmptyCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(cartItemsProvider());
  }
}
