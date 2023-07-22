import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/shared_widgets/categories.dart';

final availabilityProvider = StateProvider<bool>((ref) => false);

final categoryProvider = StateProvider<String>((ref) => ProductCategory.elec);
