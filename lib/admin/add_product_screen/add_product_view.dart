import 'package:flutter/material.dart';
import 'package:shop_management/admin/add_product_screen/drop_down_widget.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/shared_widgets/categories.dart';
import 'package:shop_management/shared_widgets/snackbars.dart';
import 'provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProductView extends ConsumerWidget {
  AddProductView({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final List<String> options = [
    ProductCategory.elec,
    ProductCategory.cloth,
    ProductCategory.foo,
    ProductCategory.boo,
    ProductCategory.gam,
    ProductCategory.spo
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Availability'),
                const SizedBox(width: 8.0),
                Switch(
                  activeColor: Colors.black,
                  value: ref.watch(availabilityProvider),
                  onChanged: (value) {
                    ref.read(availabilityProvider.notifier).state = value;
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Category :'),
                const SizedBox(
                  width: 25,
                ),
                DropdownSelectionWidget(
                  options: options,
                  selectedOption: ref.watch(categoryProvider),
                  onChanged: (newValue) {
                    ref.read(categoryProvider.notifier).state = newValue;
                  },
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              onPressed: () {
                String name = _nameController.text.trim();
                String description = _descriptionController.text;
                double price = double.parse(_priceController.text);
                int quantity = int.parse(_quantityController.text);

                ProductModel product = ProductModel(
                  name: name,
                  description: description,
                  price: price,
                  isAvailable: ref.read(availabilityProvider),
                  quantity: quantity,
                  category: ref.watch(categoryProvider),
                );

                FirestoreHandler fsh = FirestoreHandler();
                fsh.addProdcutToFirestore(product);

                _nameController.clear();
                _descriptionController.clear();
                _priceController.clear();
                _quantityController.clear();
                ref.read(availabilityProvider.notifier).state = false;

                ScaffoldMessenger.of(context)
                    .showSnackBar(CustomSnackBars.successSnackBar);
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
