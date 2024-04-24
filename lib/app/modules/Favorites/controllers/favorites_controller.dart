import 'dart:convert';

import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  List<FavItem> userFav = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    mapUserFav();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void addUserfav({required Product product}) {
    if (userFav
        .any((element) => element.product.productId == product.productId)) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Product already in cart!',
        duration: Duration(seconds: 3),
      ));
      return;
    }
    userFav.add(FavItem(product: product));
    updateLocal();
    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.green,
      message: "Product added to Favourites",
      duration: Duration(seconds: 2),
    ));
  }

  void mapUserFav() {
    var userFav =
        jsonDecode(MemoryManagement.getuserFav() ?? '[]') as List<dynamic>;
    this.userFav = userFav
        .map((e) => FavItem(product: Product.fromJson(e['product'])))
        .toList();
    print('User Fav List: $userFav');
  }

  void updateLocal() {
    MemoryManagement.setuserFav(jsonEncode(userFav
        .map((e) => {
              'product': e.product.toJson(),
            })
        .toList()));
  }

  void removeUserFav(int index) {
    userFav.removeAt(index);
    updateLocal();
    update();
  }

  void addProduct({required Product product}) {
    if (userFav
        .any((element) => element.product.productId == product.productId)) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Product already in favorites!',
        duration: Duration(seconds: 3),
      ));
      return;
    }
    void mapUserfav() {
      var userFav =
          jsonDecode(MemoryManagement.getuserFav() ?? '[]') as List<dynamic>;
      this.userFav = userFav
          .map((e) => FavItem(product: Product.fromJson(e['product'])))
          .toList();
    }
  }
}

class FavItem {
  final Product product;

  FavItem({required this.product});
}
