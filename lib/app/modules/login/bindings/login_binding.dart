import 'package:get/get.dart';

import 'package:easy_ledger/app/modules/login/providers/login_provider.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<LoginProvider>(
      () => LoginProvider(),
    );
  }
}
