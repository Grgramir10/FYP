import 'package:ecom_2/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC4DBF6),
      appBar: AppBar(
        backgroundColor: Color(0xFFC4DBF6),
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cart.length,
                  itemBuilder: (context, index) => CartCard(
                    cartItem: controller.cart[index],
                    index: index,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Total:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Obx(
                      () => Text(
                        'Rs. ${controller.total.value}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        if (controller.cart.isEmpty) {
                          Get.showSnackbar(const GetSnackBar(
                            backgroundColor: Colors.red,
                            message: 'Cart is empty!',
                            duration: Duration(seconds: 3),
                          ));
                          return;
                        }
                        var orderId = await controller.makeOrder();
                        if (orderId == null) {
                          return;
                        }
                        KhaltiScope.of(Get.context!).pay(
                          preferences: [
                            PaymentPreference.khalti,
                            PaymentPreference.connectIPS
                          ],
                          config: PaymentConfig(
                            amount: 1000,
                            productIdentity: orderId.toString(),
                            productName: "My Product",
                          ),
                          onSuccess: (PaymentSuccessModel v) {
                            controller.makePayment(
                                total: (v.amount / 100).toString(),
                                orderId: orderId.toString(),
                                otherData: v.toString());
                          },
                          onFailure: (v) {
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: Colors.red,
                              message: 'Payment failed!',
                              duration: Duration(seconds: 3),
                            ));
                          },
                          onCancel: () {
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: Colors.red,
                              message: 'Payment cancelled!',
                              duration: Duration(seconds: 3),
                            ));
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://web.khalti.com/static/img/logo1.png',
                              height: 40,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Pay with Khalti',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  final CartItem cartItem;
  final int index;

  const CartCard({Key? key, required this.cartItem, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        leading: Image.network(
          getImageUrl(cartItem.product.imageUrl),
          fit: BoxFit.cover,
          width: 80,
          height: 80,
        ),
        title: Text(
          cartItem.product.title ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price: ${cartItem.product.price}',
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller.decreaseQuantity(index);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () {
                    controller.increaseQuantity(index);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            controller.removeProduct(index);
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
