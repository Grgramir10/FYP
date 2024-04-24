import 'dart:convert';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late GlobalKey<FormState> formKey;

  @override
  void onInit() {
    super.onInit();
    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    formKey = GlobalKey<FormState>();
    getUser();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }

  void getUser() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getUserInfo');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        fullNameController.text = result['data']['full_name'];
      } else {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  void updateProfile() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      var url = Uri.http(ipAddress, 'ecom2_api/updateUserInfo');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'full_name': fullNameController.text,
        'phoneNumber': phoneNumberController.text,
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.offAllNamed(Routes.PROFILE);
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar(
        'Error',
        'Failed to update profile. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
