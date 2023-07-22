import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';

final cartItemsProvider =
    StreamProvider((ref) => FirestoreHandler().getUsersCartStream());
