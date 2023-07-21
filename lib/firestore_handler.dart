import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/models/user/user_model.dart';

class FirestoreHandler {
  final db = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage();

  Future<void> addProdcutToFirestore(ProductModel product) async {
    db.collection('Products').add(product.toJson());
  }

  Future<void> initializeUserCart(UserModel user) async {
    String userId = await getUserId(user: user);
    db.collection('Users').doc(userId).collection('Cart').add({"1": 0});
  }

  Future<void> addUserToFirestore(UserModel user) async {
    db.collection('Users').add(user.toJson());
    await initializeUserCart(user);
    String userId = await getUserId(user: user);
    storage.write(key: "userId", value: userId);
  }

  Future<UserModel> getUserFromEmail(String email) async {
    QuerySnapshot result =
        await db.collection('Users').where("email", isEqualTo: email).get();
    if (result.docs.isNotEmpty) {
      Map<String, dynamic> userMap =
          result.docs[0].data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(userMap);
      return user;
    }
    UserModel dummy = UserModel(isAdmin: true, cartItems: []);
    return dummy;
  }

  Future<String> getUserId({required UserModel user}) async {
    QuerySnapshot result = await db
        .collection('Users')
        .where("email", isEqualTo: user.email)
        .get();
    return result.docs[0].id;
  }

  Future<void> setCart(UserModel user) async {
    String userId = await getUserId(user: user);
    db
        .collection('Users')
        .doc(userId)
        .collection('Cart')
        .add(user.cartItems.last.toJson());
  }

  Future<List<ProductModel>> getCartItems(UserModel user) async {
    String userId = await getUserId(user: user);
    String? s = await storage.read(key: "userId");
    print('UserId $userId');
    print('s $s');
    QuerySnapshot result =
        await db.collection('Users').doc(userId).collection('Cart').get();

    List<ProductModel> returnList = [];

    for (var element in result.docs) {
      Map<String, dynamic> m = element.data() as Map<String, dynamic>;
      ProductModel product = ProductModel.fromJson(m);
      returnList.add(product);
    }

    return returnList;
  }
}
