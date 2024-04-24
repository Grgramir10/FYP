import 'package:ecom_2/app/modules/cart/views/cart_view.dart';
import 'package:ecom_2/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC4DBF6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC4DBF6),
        title: const Text('My Profile'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 40,
          fontStyle: FontStyle.italic,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              CircleAvatar(
                radius: 60,
                child: Text(
                  (controller.user?.fullName?[0].toUpperCase() ?? '') +
                      (controller.user?.fullName?[1].toUpperCase() ?? ''),
                  style: const TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                controller.user?.fullName?.toUpperCase() ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                color: const Color(0xFFA0F0E2),
                child: Row(
                  children: [
                    Icon(Icons.mail),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        controller.user?.email ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                MemoryManagement.getAccessRole()?.toUpperCase() ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButtonWithIcon(
                          icon: Icons.person,
                          text: 'Edit Profile',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditprofileView(),
                                ));
                          },
                        ),
                        const Divider(),
                        _buildButtonWithIcon(
                          icon: Icons.shopping_bag,
                          text: 'My Bag',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartView(),
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        _buildButtonWithIcon(
                          icon: Icons.logout,
                          text: 'Logout',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                  'Are you sure you want to logout?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      MemoryManagement.removeAll();
                                      Get.offAllNamed(Routes.LOGIN);
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButtonWithIcon({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const SizedBox(width: 10),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
