import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/shared_widgets/colours.dart';
import 'package:shop_management/user/cart_screen/widgets/cart_error_widget.dart';
import 'package:shop_management/user/cart_screen/widgets/cart_loading_widget.dart';
import 'package:shop_management/user/profile_screen/profile_view.dart';
import 'package:shop_management/user/profile_screen/provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.read(getUserProvider).when(data: (data) {
      return ProfileView(
        user: data,
      );
    }, error: (error, stack) {
      return const CartErrorWidget();
    }, loading: () {
      return const CartLoadingWidget();
    });
  }
}
