import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/shared_widgets/categories.dart';
import 'explore_screen_controller.dart';

// final productStreamProvider = StreamProvider.family((ref, int option) {
//   switch (option) {
//     case 0:
//       return ExploreController().getProductList();
//     case 1:
//       return ExploreController().getProductListBasedOnInput('yes');
//     case 2:
//       return ExploreController()
//           .getProductListBasedOnSelectedCategories([ProductCategory.foo]);
//     default:
//       return ExploreController().getProductList();
//   }
// });

final kproductStreamProvider = StreamProvider((ref) {
  if (ref.watch(inputProvider) == null) {
    return ExploreController().getProductList();
  } else {
    print('We reached here in kproductStreamProvider');
    return ExploreController()
        .getProductListWithSearchQuery(ref.read(inputProvider.notifier).state);
  }
});

final inputProvider = StateProvider<String?>((ref) => null);
