import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailedProductController extends GetxController {
  giveRating(double rating, String product_id) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/giveRating');

      var response = await http.post(url, body: {
        'rating': rating.toString(),
        'product_id': product_id.toString(),
        'token': MemoryManagement.getAccessToken()
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        HomeController().getProducts();
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  //TODO: Implement DetailedProductController
  var quantity = 1.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
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
}
