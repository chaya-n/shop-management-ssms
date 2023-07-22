import 'package:flutter/material.dart';
import 'package:shop_management/shared_widgets/categories.dart';
import 'package:shop_management/shared_widgets/colours.dart';

class CategoryScroll extends StatefulWidget {
  const CategoryScroll({Key? key}) : super(key: key);

  @override
  State<CategoryScroll> createState() => _CategoryScrollState();
}

class _CategoryScrollState extends State<CategoryScroll> {
  List<String> items = ProductCategory.categoryList;
  List<String> temp = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Card(
                color: CustomColours.secondaryColour,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    items[index],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                )),
              ),
            ),
          );
        });
  }
}
