import 'package:ecom_2/app/components/addProductPopup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemController extends GetxController {
  //TODO: Implement AddItemController

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
  void onAdd() {
    showDialog(
        context: Get.context!, builder: (context) => const AddProductPopup());
  }
}
