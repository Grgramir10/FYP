import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_main_controller.dart';
import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';

class AdminMainView extends GetView<AdminMainController> {
  const AdminMainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Obx(
      () => Scaffold(
        body: controller.screens[controller.currentIndex.value],
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white,
            selectedItemBorderColor: Colors.black,
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
              iconData: Icons.dashboard,
              label: 'Dashboard',
            ),
            FFNavigationBarItem(
              iconData: Icons.man_2,
              label: 'Users',
            ),
            FFNavigationBarItem(
              iconData: Icons.category,
              label: 'Categories',
            ),
            FFNavigationBarItem(
              iconData: Icons.inventory,
              label: 'Products',
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
