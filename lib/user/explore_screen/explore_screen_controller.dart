import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:shop_management/main.dart';

class ExploreController {
  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getProductList() {
    return db
        .collection('Products')
        .where("isAvailable", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getProductListWithSearchQuery(String? input) {
    return db
        .collection('Products')
        .where("isAvailable", isEqualTo: true)
        .where("name", isEqualTo: input)
        .snapshots();
  }
  // Stream<QuerySnapshot> getProductList(String? input) {
  //   if (input == null || input == '') {
  //     return db
  //         .collection('Products')
  //         .where("isAvailable", isEqualTo: true)
  //         .snapshots();
  //   } else {
  //     return db
  //         .collection('Products')
  //         .where("isAvailable", isEqualTo: true)
  //         .where("name", isEqualTo: input)
  //         .snapshots();
  //   }
  // }

  Stream<QuerySnapshot> getProductListBasedOnInput(String input) async* {
    QuerySnapshot querySnapshot =
        await db.collection('Products').where("name", isEqualTo: input).get();
    print('okoko${querySnapshot.docs.length}');

    yield* db
        .collection('Products')
        .where("name", isEqualTo: input)
        .snapshots();
  }

  Stream<QuerySnapshot> getProductListBasedOnSelectedCategories(
      List<String> selectedCategories) {
    return db
        .collection('Products')
        .where("category", whereIn: selectedCategories)
        .snapshots();
  }

  Stream<QuerySnapshot> searchInFireStore(
      String? input, String? category) async* {
    if (input == null && category == null) {
      yield* db.collection('Products').snapshots();
    }
    if (input == null) {
      yield* db
          .collection('Products')
          .where("category", isEqualTo: category)
          .snapshots();
    }
    if (category == null) {
      yield* db
          .collection('Products')
          .where("name", isEqualTo: input)
          .snapshots();
    } else {
      yield* db
          .collection('Products')
          .where("name", isEqualTo: input)
          .where("category", isEqualTo: category)
          .snapshots();
    }
  }
}
