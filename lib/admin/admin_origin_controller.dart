import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/admin/add_product_screen/add_product_view.dart';
import 'package:shop_management/admin/dummy.dart';
import 'package:shop_management/admin/edit_products_screen/edit_products_view.dart';

final indexProviderAdminn = StateProvider((ref) => 0);

class AdminOriginController {
  void setIndex(int newIndex, WidgetRef ref) {
    ref.read(indexProviderAdminn.notifier).state = newIndex;
  }

  List<Widget> widgetOptions = [
    AddProductView(),
    const EditProductsView(),
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: 'Add Products',
      backgroundColor: Colors.black,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.edit),
      label: 'Edit/Delete Products',
      backgroundColor: Colors.black,
    ),
  ];
}
