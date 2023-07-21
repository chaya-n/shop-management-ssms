import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_origin_controller.dart';

class UserOrigin extends ConsumerWidget {
  const UserOrigin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: UserOriginController()
          .widgetOptions
          .elementAt(ref.watch(indexProvider)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: UserOriginController().items,
        currentIndex: ref.watch(indexProvider),
        onTap: (value) => UserOriginController().setIndex(value, ref),
      ),
    );
  }
}
