import 'package:flutter/material.dart';

class QuantityIncrementer extends StatefulWidget {
  const QuantityIncrementer({super.key});

  @override
  State<QuantityIncrementer> createState() => _QuantityIncrementerState();
}

class _QuantityIncrementerState extends State<QuantityIncrementer> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).primaryColorDark),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                if (quantity != 0) {
                  quantity--;
                }
                setState(() {});
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 16,
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: Text(
              '$quantity',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          InkWell(
              onTap: () {
                quantity++;
                setState(() {});
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              )),
        ],
      ),
    );
  }
}
