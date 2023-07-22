import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shop_management/firestore_handler.dart';

final orderHistoryProvider =
    FutureProvider((ref) => FirestoreHandler().getUsersOrderHistoryFuture());
