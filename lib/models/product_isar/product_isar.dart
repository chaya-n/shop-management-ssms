import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_management/models/product/product_model.dart';

part 'product_isar.g.dart';

@collection
class ProductIsar {
  Id id = Isar.autoIncrement;
  String? name;
  String? description;
  double? price;
  bool? isAvailable;
  int? quantity;
  String? category;

  Future<Isar?> getIsarInstance() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ProductIsarSchema],
        directory: dir.path,
        inspector: true,
        name: 'OrderInstance',
      );
    }
    return Isar.getInstance('OrderInstance');
  }

  Future<void> addProductToDatabase(ProductModel productModel) async {
    final isar = await getIsarInstance();
    final productCollection = isar!.productIsars;

    ProductIsar productIsar = ProductIsar();
    productIsar
      ..category = productModel.category
      ..name = productModel.name
      ..quantity = productModel.quantity
      ..price = productModel.price
      ..description = productModel.description
      ..isAvailable = productModel.isAvailable;

    await isar.writeTxn(() async {
      await productCollection.put(productIsar);
    });
  }
}
