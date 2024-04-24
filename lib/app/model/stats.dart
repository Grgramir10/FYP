// To parse this JSON data, do
//
//     final stats = statsFromJson(jsonString);

import 'dart:convert';

Stats statsFromJson(String str) => Stats.fromJson(json.decode(str));

String statsToJson(Stats data) => json.encode(data.toJson());

class Stats {
  final String? totalIncome;
  final String? totalUsers;
  final String? totalOrders;
  final String? totalProducts;
  final List<TopCategory>? topCategories;

  Stats({
    this.totalIncome,
    this.totalUsers,
    this.totalOrders,
    this.totalProducts,
    this.topCategories,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalIncome: json["total_income"],
        totalUsers: json["total_users"],
        totalOrders: json["total_orders"],
        totalProducts: json["total_products"],
        topCategories: json["top_categories"] == null
            ? []
            : List<TopCategory>.from(
                json["top_categories"]!.map((x) => TopCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_income": totalIncome,
        "total_users": totalUsers,
        "total_orders": totalOrders,
        "total_products": totalProducts,
        "top_categories": topCategories == null
            ? []
            : List<dynamic>.from(topCategories!.map((x) => x.toJson())),
      };
}

class TopCategory {
  final dynamic categoryId;
  final String? categoryTitle;
  final dynamic totalIncome;
  final double? percentage;

  TopCategory({
    this.categoryId,
    this.categoryTitle,
    this.totalIncome,
    this.percentage,
  });

  factory TopCategory.fromJson(Map<String, dynamic> json) => TopCategory(
        categoryId: json["category_id"],
        categoryTitle: json["category_title"],
        totalIncome: json["total_income"],
        percentage: json["percentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_title": categoryTitle,
        "total_income": totalIncome,
        "percentage": percentage,
      };
}
