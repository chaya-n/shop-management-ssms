import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  String? name;
  String? description;
  double? price;
  bool? isAvailable;
  int? quantity;

  ProductModel(
      {this.name,
      this.price,
      this.description,
      this.isAvailable,
      this.quantity});

  factory ProductModel.fromJson(Map<String, dynamic> data) =>
      _$ProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
