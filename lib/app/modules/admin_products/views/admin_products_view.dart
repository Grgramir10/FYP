import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_products_controller.dart';

class AdminProductsView extends GetView<AdminProductsController> {
  const AdminProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminProductsController());
    return GetBuilder<AdminProductsController>(
      builder: (controller) => Scaffold(
        backgroundColor: Color(0xFFC4DBF6),
        appBar: AppBar(
          backgroundColor: Color(0xFFC4DBF6),
          title: const Text('All Products'),
          centerTitle: true,
        ),
        body: GetBuilder<HomeController>(builder: (controller) {
          if (controller.products == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: controller.products?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DETAILED_PRODUCT,
                        arguments: controller.products?[index]);
                  },
                  child: AdminProductCard(
                    product: controller.products![index],
                  ),
                );
              });
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.onAdd,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
