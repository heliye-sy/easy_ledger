import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../../../modules/window_wiget.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    final identifierController = TextEditingController();
    final userNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final password0Controller = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomWindow(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50, 200, 50, 0),
          child: Column(
            children: [
              Obx(() => Text(
                controller.isLogin.value ? '登录' : '注册',
                style: const TextStyle(
                  fontSize: 46.0,
                  fontFamily: 'SourceHanSerif',
                ),
              ),),

              Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    Obx(() => TextFormField(
                      controller: controller.isLogin.value ? identifierController : userNameController,
                      decoration: InputDecoration(
                        labelText: controller.isLogin.value ? '用户名/邮箱' : '用户名',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return controller.isLogin.value ? '用户名/邮箱不能为空' : '用户名不能为空';
                        }
                        if (value.length < 3) {
                          return '用户名长度必须大于三';
                        }
                        return null;
                      },
                    ),),

                    Obx(() => Offstage(
                      offstage: controller.isLogin.value,
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: '邮箱',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '邮箱不能为空';
                          }
                          if(!RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$').hasMatch(value)){
                            return '邮箱地址无效';
                          }
                          return null;
                        },
                      ),
                    ),),

                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: '密码',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '密码不能为空';
                        }
                        if (value.length < 6) {
                          return '密码长度必须大于等于 6';
                        }
                        return null;
                      },
                    ),

                    Obx(() => Offstage(
                      offstage: controller.isLogin.value,
                      child: TextFormField(
                        controller: password0Controller,
                        decoration: const InputDecoration(
                          labelText: '确认密码',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '密码不能为空';
                          }
                          if (value.length < 6) {
                            return '密码长度必须大于等于 6';
                          }
                          if (value != passwordController.text) {
                            return '两次填写的密码不一致!';
                          }
                          return null;
                        },
                      ),
                    ),),

                    const SizedBox(height: 50,),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => TextButton(
                            onPressed: () async {
                              if (loginFormKey.currentState!.validate()) {
                                // 表单验证通过
                                Map<String,String> user = controller.isLogin.value ? {
                                  "identifier": identifierController.text,
                                  "password": passwordController.text
                                } : {
                                  "username": userNameController.text,
                                  "email": emailController.text,
                                  "password": passwordController.text
                                };
                                String message =  await controller.loginUp(controller.isLogin.value ? '/auth/local' : '/auth/local/register', user);
                                Get.snackbar(
                                    '提示',
                                    message,
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.green
                                );
                              } else {
                                // 表单验证失败
                                print('表单验证失败');
                              }
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.black),
                              backgroundColor: MaterialStateProperty.all(Colors.yellow),
                            ),
                            child: Text(controller.isLogin.value ? '登录' : '注册'),
                          )),

                          const SizedBox(width: 100,),

                          TextButton(
                              onPressed: () => controller.isLogin.toggle(),
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(Colors.black),
                              ),
                              child: Obx(() => Text(controller.isLogin.value ? '立即注册' : '回到登录'))
                          )
                        ],
                      ),
                    )

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
