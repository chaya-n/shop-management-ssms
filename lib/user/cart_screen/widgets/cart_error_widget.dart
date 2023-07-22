import 'package:flutter/material.dart';

class CartErrorWidget extends StatelessWidget {
  const CartErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Something Went Wrong. Check your Internet'),
    );
  }
}
