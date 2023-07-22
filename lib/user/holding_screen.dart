import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/admin/add_product_screen/add_product_view.dart';
import 'package:shop_management/admin/admin_origin.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/user/myApp.dart';
import 'package:shop_management/user/user_origin.dart';

class Holdingscreen extends ConsumerStatefulWidget {
  const Holdingscreen({Key? key}) : super(key: key);

  @override
  _HoldingscreenState createState() => _HoldingscreenState();
}

class _HoldingscreenState extends ConsumerState<Holdingscreen> {
  @override
  Widget build(BuildContext context) {
    FirestoreHandler().checkIfUserIsAdmin(ref);
    return Scaffold(
      body: (ref.watch(adminProvider) == true) ? AdminOrigin() : UserOrigin(),
    );
  }
}
