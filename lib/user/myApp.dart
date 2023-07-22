import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/admin/add_product_screen/add_product_view.dart';
import 'package:shop_management/login_screen/firebaseAuth_handler.dart';
import 'package:shop_management/login_screen/login_view.dart';
import 'package:shop_management/user/holding_screen.dart';
import 'package:shop_management/user/user_origin.dart';

final userAuthStateProvider =
    StreamProvider<User?>((ref) => Auth().onAuthStateChanged());

final adminProvider = StateProvider<bool>((ref) => false);

bool isAdminGlobalVariable = false;

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userAuthStateProvider).when(data: (data) {
      if (data == null) {
        return LoginPage();
      } else {
        return Holdingscreen();
      }
    }, error: (error, stack) {
      return const Placeholder();
    }, loading: () {
      return const Center(
        child: Text('Welcome!'),
      );
    });
  }
}
