// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String? productId;
  final String? title;
  final String? description;
  final String? categoryId;
  final String? imageUrl;
  final String? isAvailable;
  final String? price;
  final String? isVerified;
  final String? rating;
  final String? userId;
  final String? categoryTitle;
  final String? fullName;
  final String? password;
  final String? email;
  final String? role;
  final String? phoneNumber;
  final String? location;

  Product({
    this.productId,
    this.title,
    this.description,
    this.categoryId,
    this.imageUrl,
    this.isAvailable,
    this.price,
    this.isVerified,
    this.rating,
    this.userId,
    this.categoryTitle,
    this.fullName,
    this.password,
    this.email,
    this.role,
    this.phoneNumber,
    this.location,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        title: json["title"],
        description: json["description"],
        categoryId: json["category_id"],
        imageUrl: json["image_url"],
        isAvailable: json["is_available"],
        price: json["price"],
        isVerified: json["is_verified"],
        rating: json["rating"],
        userId: json["user_id"],
        categoryTitle: json["category_title"],
        fullName: json["full_name"],
        password: json["password"],
        email: json["email"],
        role: json["role"],
        phoneNumber: json["phoneNumber"],
        location: json["Location"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "title": title,
        "description": description,
        "category_id": categoryId,
        "image_url": imageUrl,
        "is_available": isAvailable,
        "price": price,
        "is_verified": isVerified,
        "rating": rating,
        "user_id": userId,
        "category_title": categoryTitle,
        "full_name": fullName,
        "password": password,
        "email": email,
        "role": role,
        "phoneNumber": phoneNumber,
        "Location": location,
      };
}
