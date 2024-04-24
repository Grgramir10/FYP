// ignore_for_file: must_be_immutable

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/admin_products/controllers/admin_products_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AdminProductCard extends StatefulWidget {
  final Product product;
  // final AdminProductsController controller;

  AdminProductCard({Key? key, required this.product}) : super(key: key);
  var controller = Get.put(AdminProductsController());

  @override
  _AdminProductCardState createState() => _AdminProductCardState();
}

class _AdminProductCardState extends State<AdminProductCard> {
  bool _isVerified = false;
  // late AdminProductsController _controller;

  @override
  void initState() {
    super.initState();

    // _controller = Get.put(AdminProductsController());
  }

  @override
  Widget build(BuildContext context) {
    _isVerified = widget.product.isVerified == '1';
    return Container(
      height: 95,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.network(
            getImageUrl(widget.product.imageUrl),
            width: 75,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              widget.product.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Visibility(
            visible: MemoryManagement.getAccessRole() == "admin",
            child: _isVerified
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Verified',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      _verifyProduct();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey, // Initial button color
                    ),
                    child: Text(
                      'Verify',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: MemoryManagement.getAccessRole() == 'admin',
            child: IconButton(
              onPressed: () {
                widget.controller.deleteProduct(widget.product.productId!);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _verifyProduct() {
    widget.controller.verifyProduct(widget.product.productId!).then((success) {
      if (success) {
        setState(() {
          _isVerified = true;
          // Update button state upon successful verification
        });
      }
    });
  }
}
