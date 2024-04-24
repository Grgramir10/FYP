import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

import '../controllers/detailed_product_controller.dart';

class DetailedProductView extends GetView<DetailedProductController> {
  const DetailedProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as Product;
    var cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title?.toUpperCase() ?? ''),
        centerTitle: true,
      ),
      body: GetBuilder<DetailedProductController>(
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'product+${product.productId}',
                  child: Image.network(
                    width: double.infinity,
                    height: Get.height * 0.38,
                    getImageUrl(product.imageUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Posted By: ' + product.fullName!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.title?.toUpperCase() ?? '',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone), // Phone icon
                          InkWell(
                            onTap: () {
                              _launchPhoneCall(product.phoneNumber!);
                            },
                            child: Text(
                              ' ${product.phoneNumber!}', // Display phone number
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        product.description ?? '',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Product Rating : ${product.rating ?? ''}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Rs.' + product.price.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Give Rating:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: double.parse(product.rating!),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                          controller.giveRating(rating, product.productId!);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (controller.quantity > 1) {
                      controller.quantity--;
                    }
                  },
                  icon: Icon(Icons.remove),
                ),
                Obx(
                  () => Text(
                    controller.quantity.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.quantity++;
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            MyButton(
              tittle: 'Add to Cart',
              onPressed: () {
                cartController.addProduct(
                  product: product,
                  quantity: controller.quantity.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch phone call
  void _launchPhoneCall(String phoneNumber) async {
    print('Launching phone call to: $phoneNumber');
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Error launching phone call');
      throw 'Could not launch $url';
    }
  }
}
