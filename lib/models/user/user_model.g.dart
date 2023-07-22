// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      isAdmin: json['isAdmin'] as bool?,
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      password: json['password'] as String?,
      email: json['email'] as String?,
      categoryPref: (json['categoryPref'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'isAdmin': instance.isAdmin,
      'cartItems': instance.cartItems,
      'email': instance.email,
      'password': instance.password,
      'categoryPref': instance.categoryPref,
    };
