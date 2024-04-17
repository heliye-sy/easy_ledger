import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:screen_go/extensions/responsive_nums.dart';
import 'package:screen_go/extensions/orienation_type_value.dart';
import 'package:screen_go/extensions/screen_type_value.dart';

import '../controllers/login_controller.dart';
import '../../../modules/window_wiget.dart';
import 'form_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomWindow(
        body: Center(
          child: stv(
            context: context,
            // 手机
            mobile: otv(
              context: context,
              // 手机竖向
              portrait: Column(
                children: [
                  Container(
                    height: 30.0.h,
                    alignment: Alignment.bottomCenter,
                    child: Obx(() => Text(
                      controller.isLogin.value == 'login' ? '登录' : controller.isLogin.value == 'register' ? '注册' : '重置密码',
                      style: TextStyle(
                        fontSize: 30.0.sp,
                        fontFamily: 'SourceHanSerif',
                      ),
                    ),),
                  ),
                  const FormView(),
                ],
              ),

              // 手机横向
              landscape: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 100.h,
                    alignment: Alignment.center,
                    child: Obx(() => Text(
                      controller.isLogin.value == 'login' ? '登录' : controller.isLogin.value == 'register' ? '注册' : '重置密码',
                      style: TextStyle(
                        fontSize: 30.0.sp,
                        fontFamily: 'SourceHanSerif',
                      ),
                    ),),
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
              ),
            ),

            // web屏幕(没有最大化大)
            tablet: Column(
              children: [
                Container(
                  height: 30.0.h,
                  alignment: Alignment.bottomCenter,
                  child: Obx(() => Text(
                    controller.isLogin.value == 'login' ? '登录' : controller.isLogin.value == 'register' ? '注册' : '重置密码',
                    style: TextStyle(
                      fontSize: 30.0.sp,
                      fontFamily: 'SourceHanSerif',
                    ),
                  ),),
                ),
                const FormView(),
              ],
            ),

            // pc屏幕
            desktop: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 100.h,
                  alignment: Alignment.center,
                  child: Obx(() => Text(
                    controller.isLogin.value == 'login' ? '登录' : controller.isLogin.value == 'register' ? '注册' : '重置密码',
                    style: TextStyle(
                      fontSize: 30.0.sp,
                      fontFamily: 'SourceHanSerif',
                    ),
                  ),),
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
            ),
          ),
        ),
      ),
    );
  }
}
