import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../window_wiget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomWindow(
        body: Column(
          children: [
            AppBar(
              // leading: Image.network(''),
              backgroundColor: Colors.blue,
            ),
            Container(
              child: controller.obx(
                    (user) {
                      return Text(user?.username ?? '');
                },
                onError: (error) => Center(
                  child: TextButton(
                    onPressed: () => Get.offAllNamed('/login'),
                    child: Text(
                        error!
                    ),
                  ),
                ), //出错界面显示
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          controller.rmJwt();
        },
        child: const Text('退出登录'),
      ),
    );
  }
}
