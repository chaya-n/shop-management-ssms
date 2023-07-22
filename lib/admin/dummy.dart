import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:select_card/select_card.dart';

class Dummy extends StatefulWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SelectGroupCard(context,
          titles: ['hi', 'hello'],
          imageSourceType: ImageSourceType.network,
          contents: ['ok', 'nokay'],
          cardBackgroundColor: const Color.fromARGB(255, 128, 201, 235),
          cardSelectedColor: Colors.deepOrange,
          titleTextColor: Colors.blue.shade900,
          contentTextColor: Colors.black87, onTap: (title) {
        debugPrint(title);
      }),
    );
  }
}
