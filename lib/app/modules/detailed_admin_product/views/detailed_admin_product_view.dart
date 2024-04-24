import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detailed_admin_product_controller.dart';

class DetailedAdminProductView extends GetView<DetailedAdminProductController> {
  const DetailedAdminProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title?.toUpperCase() ?? ''),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product+${product.productId}',
              child: Image.network(
                getImageUrl(product.imageUrl ?? ''),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Posted By: ${product.fullName ?? ''}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.title?.toUpperCase() ?? '',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.description ?? '',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Rs. ${product.price.toString()}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
