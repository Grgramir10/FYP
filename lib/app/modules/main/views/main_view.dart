import 'package:ff_navigation_bar_plus/ff_navigation_bar_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.screens[controller.currentIndex.value],
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white,
            selectedItemBorderColor: Colors.blue,
            selectedItemBackgroundColor: Colors.black,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
          ),
          onSelectTab: (int val) {
            controller.currentIndex.value = val;
          },
          selectedIndex: controller.currentIndex.value,
          items: [
            FFNavigationBarItem(
              iconData: Icons.home,
              label: 'Home',
            ),
            FFNavigationBarItem(
              iconData: Icons.favorite,
              label: 'Favorites',
            ),
            FFNavigationBarItem(
              iconData: Icons.add,
              label: 'Add Item',
            ),
            FFNavigationBarItem(
              iconData: Icons.shopping_cart,
              label: 'Cart',
            ),
            FFNavigationBarItem(
              iconData: Icons.person,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
