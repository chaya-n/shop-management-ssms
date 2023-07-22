import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_management/login_screen/firebaseAuth_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/models/user/user_model.dart';
import 'package:shop_management/user/myApp.dart';

class FirestoreHandler {
  final db = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage();

  Future<String?> getUserIdFromStorage() async {
    String? s = await storage.read(key: "userId");
    return s;
  }

  Future<void> addProdcutToFirestore(ProductModel product) async {
    db.collection('Products').add(product.toJson());
  }

  Stream getAllProductsForAdmin() async* {
    yield* db.collection('Products').snapshots();
  }

  Future<void> updateProduct(ProductModel product, String? initialName) async {
    QuerySnapshot result = await db
        .collection('Products')
        .where("name", isEqualTo: initialName)
        .get();
    DocumentReference docRef = result.docs.first.reference;
    await docRef.update(product.toJson());
  }

  Future<void> deleteProduct(ProductModel product) async {
    QuerySnapshot result = await db
        .collection('Products')
        .where("name", isEqualTo: product.name)
        .get();
    DocumentReference docRef = result.docs.first.reference;
    await docRef.delete();
  }

  Future<void> initializeUserCart(UserModel user) async {
    String? userId = await storage.read(key: "userId");
    db
        .collection('Users')
        .doc(userId)
        .collection('Cart')
        .doc('0')
        .set({"0": 0});
    db.collection('Users').doc(userId).collection('Cart').doc("0").delete();
  }

  Future<void> addUserToFirestore(UserModel user) async {
    db.collection('Users').add(user.toJson());
    String userId = await getUserId(user: user);
    storage.write(key: "userId", value: userId);
    await initializeUserCart(user);
  }

  Future<UserModel> getCurrentUser() async {
    String? userId = await storage.read(key: "userId");
    DocumentSnapshot result = await db.collection('Users').doc(userId).get();
    Map<String, dynamic> m = result.data() as Map<String, dynamic>;
    UserModel user = UserModel.fromJson(m);
    return user;
  }

  Future<String> getUserId({required UserModel user}) async {
    QuerySnapshot result = await db
        .collection('Users')
        .where("email", isEqualTo: user.email)
        .get();

    return result.docs[0].id;
  }

  Future<void> setCart(UserModel user) async {
    String? userId = await storage.read(key: "userId");
    bool flag = false;
    ProductModel product = user.cartItems.last;
    DocumentReference dummy;
    QuerySnapshot result =
        await db.collection('Users').doc(userId).collection('Cart').get();

    for (var element in result.docs) {
      Map m = element.data() as Map;
      if (m['name'] == product.name) {
        flag = true;
        dummy = element.reference;
        dummy.update(product.toJson());
        break;
      }
    }

    if (!flag) {
      db
          .collection('Users')
          .doc(userId)
          .collection('Cart')
          .add(user.cartItems.last.toJson());
    }
  }

  Future<List<ProductModel>> getCartItems() async {
    String? userId = await storage.read(key: "userId");
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

  Future<bool> isCartEmpty() async {
    UserModel user = await getCurrentUser();
    bool returnBool = (user.cartItems.isEmpty) ? true : false;
    return returnBool;
  }

  Future<void> emptyCart() async {
    String? userId = await storage.read(key: "userId");
    QuerySnapshot result =
        await db.collection('Users').doc(userId).collection('Cart').get();
    result.docs.forEach((element) async {
      await element.reference.delete();
    });
  }

  Future<void> deleteUserIdFromStorage() async {
    await storage.deleteAll();
  }

  Future<void> signOutCurrentUser() async {
    await storage.deleteAll();
    await Auth().signOutCurrentUser();
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

  Future<void> checkIfUserIsAdmin(WidgetRef ref) async {
    UserModel user = await getCurrentUser();
    if (user.isAdmin == true) {
      ref.watch(adminProvider.notifier).state = true;
    }
  }

  Future<void> addUserIdToStorage(String email, WidgetRef ref) async {
    UserModel user = await getUserFromEmail(email);
    if (user.isAdmin == true) {}
    String userId = await getUserId(user: user);
    await storage.write(key: "userId", value: userId);
  }

  Stream<QuerySnapshot<Object?>> getUsersCartStream() async* {
    String? userId = await storage.read(key: "userId");
    yield* db.collection('Users').doc(userId).collection('Cart').snapshots();
  }

  Future<int> placeOrder() async {
    List<Map> itemsInTheOrder = [];
    String? userId = await storage.read(key: "userId");
    QuerySnapshot result =
        await db.collection('Users').doc(userId).collection('Cart').get();
    String idToSaveThisOrder = result.docs.first.id;
    try {
      result.docs.forEach((element) async {
        Map<String, dynamic> m = element.data() as Map<String, dynamic>;
        itemsInTheOrder.add(m);
        QuerySnapshot matchedProduct = await db
            .collection("Products")
            .where("name", isEqualTo: m['name'])
            .get();
        String matchedProductid = matchedProduct.docs.first.id;
        Map<String, dynamic> m2 =
            matchedProduct.docs.first.data() as Map<String, dynamic>;
        m2['quantity'] = m2['quantity'] - m['quantity'];
        db.collection('Products').doc(matchedProductid).set(m2);
      });
    } catch (e) {
      return -1;
    }
    // emptyCart();
    saveOrder(itemsInTheOrder, idToSaveThisOrder).then((value) {
      emptyCart();
    });
    return 1;
  }

  Future<void> saveOrder(List<Map> itemsToSave, String s) async {
    String? userId = await storage.read(key: "userId");
    db
        .collection('Users')
        .doc(userId)
        .collection('Orders')
        .doc(s)
        .set({"0": 0});
    String docPath =
        db.collection('Users').doc(userId).collection('Orders').doc(s).path;
    for (var element in itemsToSave) {
      db.doc(docPath).collection('Items').add(element as Map<String, dynamic>);
    }
  }

  Future<List<List<ProductModel>>> getUsersOrderHistoryFuture() async {
    String? userId = await storage.read(key: "userId");
    QuerySnapshot result =
        await db.collection('Users').doc(userId).collection('Orders').get();

    List<List<ProductModel>> returnList = [];

    // result.docs.forEach((element) async {
    //   DocumentReference docRef = element.reference;
    //   List<ProductModel> dummy = [];
    //   QuerySnapshot result = await docRef.collection('Items').get();
    //   print('re ${result.docs.length}');
    //   for (var doc in result.docs) {
    //     Map<String, dynamic> m = doc.data() as Map<String, dynamic>;
    //     print('the map $m');
    //     ProductModel product = ProductModel.fromJson(m);
    //     print('the product ${product.price} ${product.name} $product');
    //     dummy.add(product);
    //     print('thelenght fo od dummy  ${dummy.length}');
    //   }
    //   returnList.add(dummy);
    //   print('thelenght fo od dummy  ${returnList.length}');
    // });
    for (var element in result.docs) {
      DocumentReference docRef = element.reference;
      List<ProductModel> dummy = [];
      QuerySnapshot result = await docRef.collection('Items').get();
      for (var doc in result.docs) {
        Map<String, dynamic> m = doc.data() as Map<String, dynamic>;
        ProductModel product = ProductModel.fromJson(m);
        dummy.add(product);
      }
      returnList.add(dummy);
    }
    print('ReturnList ${returnList.length}');

    return returnList;
  }

  Future<void> dummyFunction() async {}
}
