import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/firestore_handler.dart';

final providerForAllProductsForAdmin =
    StreamProvider((ref) => FirestoreHandler().getAllProductsForAdmin());
