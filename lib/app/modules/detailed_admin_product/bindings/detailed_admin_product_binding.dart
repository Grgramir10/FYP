import 'package:get/get.dart';

import '../controllers/detailed_admin_product_controller.dart';

class DetailedAdminProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedAdminProductController>(
      () => DetailedAdminProductController(),
    );
  }
}
