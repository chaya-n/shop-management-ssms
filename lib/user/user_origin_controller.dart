import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/user/cart_screen/cart_view.dart';
import 'package:shop_management/user/explore_screen/explore_screen_view.dart';

final indexProvider = StateProvider((ref) => 0);

class UserOriginController {
  void setIndex(int newIndex, WidgetRef ref) {
    ref.read(indexProvider.notifier).state = newIndex;
  }

  List<Widget> widgetOptions = [
    const ExploreView(),
    const CartView(),
    const Center(
      child: CircularProgressIndicator(),
    )
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Explore',
      backgroundColor: Colors.grey,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_rounded),
      label: 'Account',
      backgroundColor: Colors.blueGrey,
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Cart',
        backgroundColor: Colors.black),
  ];
}
