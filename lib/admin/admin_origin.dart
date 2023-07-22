import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/admin/admin_origin_controller.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/login_screen/firebaseAuth_handler.dart';

class AdminOrigin extends ConsumerWidget {
  const AdminOrigin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Welcome Admin'),
          actions: [
            IconButton(
                onPressed: () {
                  FirestoreHandler().signOutCurrentUser();
                },
                icon: const Icon(
                  Icons.logout,
                  semanticLabel: 'Log out',
                ))
          ],
        ),
        body: AdminOriginController()
            .widgetOptions
            .elementAt(ref.watch(indexProviderAdminn)),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: AdminOriginController().items,
          currentIndex: ref.watch(indexProviderAdminn),
          onTap: (value) => AdminOriginController().setIndex(value, ref),
        ),
      ),
    );
  }
}
