import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:screen_go/extensions/responsive_nums.dart';
import 'package:screen_go/extensions/orienation_type_value.dart';

import '../controllers/login_controller.dart';
import '../../../modules/window_wiget.dart';
import 'form_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Widget logTitle = Obx(() => Text(
      controller.isLogin.value == 'login' ? '登录' : controller.isLogin.value == 'register' ? '注册' : '重置密码',
      style: TextStyle(
        fontSize: 30.0.sp,
        fontFamily: 'SourceHanSerif',
      ),
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomWindow(
        body: Container(
          child: otv(
              context: context,
              portrait: Column(
                children: [
                  Container(
                    height: 40.h,
                    padding: EdgeInsets.only(bottom: 5.h),
                    alignment: Alignment.bottomCenter,
                    child: logTitle,
                  ),
                  const FormView()
                ],
              ),
              landscape: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 100.h,
                    alignment: Alignment.center,
                    child: logTitle,
                  ),
                  Container(
                    width: 1.0,
                    height: 80.0.h,
                    color: Colors.blue,
                  ),
                  const Expanded(
                      child: FormView()
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
