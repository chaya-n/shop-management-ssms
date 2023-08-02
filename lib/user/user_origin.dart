import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_origin_controller.dart';

class UserOrigin extends ConsumerWidget {
  const UserOrigin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('SHOP'),
          backgroundColor: Color.fromARGB(255, 25, 30, 30),
        ),
        backgroundColor: Color.fromARGB(255, 12, 15, 20),
        body: UserOriginController()
            .widgetOptions
            .elementAt(ref.watch(indexProvider)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 25, 30, 30),
          selectedItemColor: Color.fromARGB(255, 209, 119, 66),
          unselectedItemColor: Color.fromARGB(255, 81, 82, 86),
          type: BottomNavigationBarType.fixed,
          items: UserOriginController().items,
          currentIndex: ref.watch(indexProvider),
          onTap: (value) => UserOriginController().setIndex(value, ref),
        ),
      ),
    );
  }
}
