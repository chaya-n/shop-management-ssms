import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'explore_screen_controller.dart';

final productStreamProvider =
    StreamProvider((ref) => ExploreController().getProductList());
