import 'dart:convert';

import 'package:ecom_2/app/components/addProductPopup.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminProductsController extends GetxController {
  void onAdd() {
    showDialog(
        context: Get.context!, builder: (context) => const AddProductPopup());
  }

  verifyProduct(String productId) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/verifyProduct');
      var response = await http.post(
        url,
        body: {
          'product_id': productId,
          'token': MemoryManagement.getAccessToken(),
        },
      );

      var result = jsonDecode(response.body);

      if (result['message'] == 'Product verified') {
        // Handle successful verification (e.g., update product status)
        // For example, you can update the product status in your UI
        update();
        Get.find<HomeController>().getProducts();
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.green,
            messageText: Text('Product verified successfully'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            messageText: Text(result['message'] ?? 'Failed to verify product'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: Colors.red,
          messageText: Text('Something went wrong'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void deleteProduct(String productId) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/deleteProduct');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'product_id': productId
      });

      var result = jsonDecode(response.body);
      print(result);

      if (result['success']) {
        update();
        Get.find<HomeController>().getProducts();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
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
}

// void onDeleteClicked({required String productId}) async {
//   try {
//     var url = Uri.http(ipAddress, 'ecom2_api/deleteProduct');
//     // await Future.delayed(const Duration(seconds: 3));

//     var response = await http.post(url, body: {
//       'product_id': productId,
//       'token': MemoryManagement.getAccessToken()
//     });

//     var result = jsonDecode(response.body);

//     if (result['success']) {
//       Get.back();
//       Get.showSnackbar(GetSnackBar(
//         backgroundColor: Colors.red,
//         message: result['message'],
//         duration: const Duration(seconds: 3),
//       ));
//       // var homeController = Get.find<HomeController>();
//       // homeController.getProducts();
//     } else {
//       Get.showSnackbar(GetSnackBar(
//         backgroundColor: Colors.red,
//         message: result['message'],
//         duration: const Duration(seconds: 3),
//       ));
//     }
//   } catch (e) {
//     print(e);
//     Get.showSnackbar(const GetSnackBar(
//       backgroundColor: Colors.red,
//       message: 'Something went wrong',
//       duration: Duration(seconds: 3),
//     ));
//   }
// }
