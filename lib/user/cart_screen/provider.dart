import 'package:riverpod/riverpod.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/user/user_model.dart';

final cartItemsProvider = FutureProvider.family(
    (ref, UserModel user) => FirestoreHandler().getCartItems(user));
