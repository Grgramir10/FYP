import 'package:ecom_2/app/modules/Add%20Item/views/add_item_view.dart';
import 'package:ecom_2/app/modules/Favorites/views/favorites_view.dart';
import 'package:ecom_2/app/modules/cart/views/cart_view.dart';
import 'package:ecom_2/app/modules/home/views/home_view.dart';
import 'package:ecom_2/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List<Widget> screens = [
    const HomeView(),
    const FavoritesView(),
    const AddItemView(),
    const CartView(),
    const ProfileView()
  ];

  var currentIndex = 0.obs;

  final count = 0.obs;

  void increment() => count.value++;
}
