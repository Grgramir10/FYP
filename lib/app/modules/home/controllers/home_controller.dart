import 'dart:convert';

import 'package:ecom_2/app/components/addProductPopup.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/Favorites/controllers/favorites_controller.dart';

import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // late final SharedPreferences prefs;
  List<Category>? categories;
  List<Product>? products;
  final count = 0.obs;
  String? selectedCategory;
  final ImagePicker picker = ImagePicker();
  var addProductFormKey = GlobalKey<FormState>();
  var addCategoryFormKey = GlobalKey<FormState>();

  XFile? productImage;
  Uint8List? imageBytes;

  //
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();

  var categoryNameController = TextEditingController();

  List<FavItem> userFav = [];

  @override
  void onInit() async {
    super.onInit();
    // prefs = await SharedPreferences.getInstance();
    getCategories();
    getProducts();
  }

  void onPickImage() async {
    try {
      productImage = await picker.pickImage(source: ImageSource.gallery);
      imageBytes = await productImage!.readAsBytes();
      update();
    } catch (e) {}
  }

  void getCategories() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getCategory');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http.get(
        url,
      );

      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //   backgroundColor: Colors.green,
        //   message: result['message'],
        //   duration: const Duration(seconds: 3),
        // ));
        categories = categoryFromJson(jsonEncode(result['data']));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void addProduct() async {
    try {
      if (addProductFormKey.currentState!.validate()) {
        try {
          var url = Uri.http(ipAddress, 'ecom2_api/addProduct');

          var request = http.MultipartRequest('POST', url);

          request.fields['title'] = titleController.text;
          request.fields['description'] = descriptionController.text;
          request.fields['price'] = priceController.text;
          request.fields['category'] = selectedCategory!;
          request.fields['token'] = MemoryManagement.getAccessToken()!;

          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              imageBytes!,
              filename: productImage!.name,
            ),
          );

          var responseData = await request.send();

          var response = await http.Response.fromStream(responseData);

          // var response = await http.post(url, body: {
          //   'title': titleController.text,
          //   'description': descriptionController.text,
          //   'price': priceController.text,
          //   'category': selectedCategory,
          //   'token': MemoryManagement.getAccessToken()
          //   // 'token':prefs.getString('token')
          // });

          var result = jsonDecode(response.body);

          if (result['success']) {
            Get.back();
            getProducts();
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
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Something went wrong',
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {}
  }

  void addCategory() async {
    try {
      if (addCategoryFormKey.currentState!.validate()) {
        try {
          var url = Uri.http(ipAddress, 'ecom2_api/addCategory');

          var response = await http.post(url, body: {
            'title': categoryNameController.text,
            'token': MemoryManagement.getAccessToken()
          });

          var result = jsonDecode(response.body);

          if (result['success']) {
            Get.back();
            getCategories();
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
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Something went wrong',
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {}
  }

  void onLogout() async {
    // await prefs.remove('token');
    MemoryManagement.removeAll();
    Get.offAllNamed(Routes.LOGIN);
  }

  void getProducts() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getProduct');
      var response = await http
          .post(url, body: {'token': MemoryManagement.getAccessToken()});

      print(response.body);

      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //   backgroundColor: Colors.green,
        //   message: result['message'],
        //   duration: const Duration(seconds: 3),
        // ));

        products = productFromJson(
          jsonEncode(result['data']),
        );
        update();
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

  void increment() => count.value++;
}
