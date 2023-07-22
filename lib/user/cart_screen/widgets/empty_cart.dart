import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: SvgPicture.asset(
        'lib/images/empty_cart.svg',
        semanticsLabel: 'Empty Cart',
        color: Colors.white,
      ),
    ));
  }
}
