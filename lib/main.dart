import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_management/user/myApp.dart';
import 'package:shop_management/user/user_origin.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/product_isar/product_isar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [ProductIsarSchema],
    directory: dir.path,
    inspector: true,
  );

  runApp(ProviderScope(
      child: MaterialApp(
    home: MyApp(),
    routes: {
      'MyApp': (context) => const MyApp(),
      '/UserOrigin': (context) => const UserOrigin(),
    },
  )));
}
