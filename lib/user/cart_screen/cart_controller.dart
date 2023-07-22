import 'package:cloud_firestore/cloud_firestore.dart';

class ExploreController {
  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getProductList() {
    return db.collection('Products').snapshots();
  }
}
