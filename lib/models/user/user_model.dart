import 'package:json_annotation/json_annotation.dart';
import 'package:shop_management/models/product/product_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? firstName;
  String? lastName;
  String? phone;
  bool? isAdmin;
  List<ProductModel> cartItems;
  String? email;
  String? password;
  List<String>? categoryPref;

  UserModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.isAdmin,
    required this.cartItems,
    this.password,
    this.email,
    this.categoryPref,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) =>
      _$UserModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
