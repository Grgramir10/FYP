import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesController());
    return Scaffold(
      backgroundColor: Color(0xFFC4DBF6),
      appBar: AppBar(
        backgroundColor: Color(0xFFC4DBF6),
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: GetBuilder<FavoritesController>(
        builder: (controller) => Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 1000,
                  child: ListView.builder(
                      itemCount: controller.userFav.length,
                      itemBuilder: (context, index) => UserFavCard(
                            favItem: controller.userFav[index],
                            index: index,
                          )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserFavCard extends StatelessWidget {
  final FavItem favItem;
  final int index;
  const UserFavCard({super.key, required this.favItem, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavoritesController>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.DETAILED_PRODUCT,
                arguments: Product.fromJson(favItem.product.toJson()));
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]),
            margin: const EdgeInsets.only(bottom: 20),
            height: 110,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    getImageUrl(favItem.product.imageUrl),
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          favItem.product.title ?? '',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price: ${favItem.product.price}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {
              controller.removeUserFav(index);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
