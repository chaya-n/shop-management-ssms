import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/user/cart_screen/cart_view.dart';
import 'package:shop_management/user/explore_screen/explore_screen_view.dart';
import 'package:shop_management/user/profile_screen/profile_page.dart';
import 'package:shop_management/user/profile_screen/profile_view.dart';

import 'order_history_screen/order_history_view.dart';

final indexProvider = StateProvider((ref) => 0);

class UserOriginController {
  void setIndex(int newIndex, WidgetRef ref) {
    ref.read(indexProvider.notifier).state = newIndex;
  }

  List<Widget> widgetOptions = [
    const ExploreView(),
    const CartVieww(),
    const OrderHistoryView(),
    const ProfileScreen(),
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Explore',
      backgroundColor: Colors.grey,
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Cart',
        backgroundColor: Colors.black),
    const BottomNavigationBarItem(
        icon: Icon(Icons.history_sharp),
        label: 'Order History',
        backgroundColor: Colors.black),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_rounded),
      label: 'Account',
      backgroundColor: Colors.blueGrey,
    ),
  ];
}
