import 'package:flutter/material.dart';
import 'package:shop_management/admin/add_product_screen/drop_down_widget.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/models/product/product_model.dart';
import 'package:shop_management/shared_widgets/categories.dart';
import 'package:shop_management/shared_widgets/snackbars.dart';

class ProductEditPage extends StatefulWidget {
  final ProductModel product;

  const ProductEditPage({super.key, required this.product});

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
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
  bool _isAvailable = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name ?? '';
    _descriptionController.text = widget.product.description ?? '';
    _priceController.text = widget.product.price?.toString() ?? '';
    _quantityController.text = widget.product.quantity?.toString() ?? '';
    _isAvailable = widget.product.isAvailable ?? false;
  }

  @override
  Widget build(BuildContext context) {
    String selectedOption = widget.product.category ?? 'Electronics';
    final String? initialName = widget.product.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            SizedBox(height: 16.0),
            DropdownSelectionWidget(
              options: options,
              selectedOption: selectedOption,
              onChanged: (newValue) {
                setState(() {
                  selectedOption = newValue;
                  widget.product.category = newValue;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Available'),
                Switch(
                  activeColor: Colors.black,
                  value: _isAvailable,
                  onChanged: (value) {
                    setState(() {
                      _isAvailable = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                widget.product.name = _nameController.text.trim();
                widget.product.description = _descriptionController.text;
                widget.product.price = double.tryParse(_priceController.text);
                widget.product.quantity =
                    int.tryParse(_quantityController.text);
                widget.product.isAvailable = _isAvailable;

                try {
                  FirestoreHandler()
                      .updateProduct(widget.product, initialName)
                      .then((value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(CustomSnackBars.successSnackBar);
                    Navigator.of(context).pop();
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(CustomSnackBars.failureSnackBar);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
