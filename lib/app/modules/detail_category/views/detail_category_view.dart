import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  const DetailCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Category? category;
    final dynamic argument = Get.arguments;

    if (argument is Category) {
      category = argument;
    }

    return Scaffold(
      backgroundColor: Color(0xFFC4DBF6),
      appBar: AppBar(
        backgroundColor: Color(0xFFcaf0f8),
        title: Text(category?.categoryTitle ?? ''),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) => SizedBox(
            height: 100,
            child: AdminProductCard(
              product: controller.products[index],
            ),
          ),
        ),
      ),
    );
  }
}
