import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class FormView extends GetView<LoginController> {
  const FormView({super.key});

  InputDecoration inputDecoration({required String labelText, Widget? icon}) {
    var customBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(style: BorderStyle.none)
    );
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      suffixIcon: icon,
      border: customBorder,
      enabledBorder:customBorder,
      focusedBorder:customBorder,
      focusedErrorBorder: customBorder,
      errorBorder: customBorder,
        filled: true,
        fillColor: const Color(0xffF6F6F8),
        //隐藏下划线
        //border: InputBorder.none,
        hintStyle: const TextStyle(fontSize: 15, color: Color(0xffAEAEAE)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    final identifierController = TextEditingController();
    final userNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final password0Controller = TextEditingController();
    final isShowPassword = true.obs;
    return Container(
      padding: const EdgeInsets.all(50),
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Offstage(
              offstage: controller.isLogin.value == 'rmPassword' ? true : false,
              child: TextFormField(
                controller: controller.isLogin.value == 'login' ? identifierController : userNameController,
                decoration: inputDecoration(labelText: controller.isLogin.value == 'login' ? '用户名/邮箱' : '用户名'),
                cursorColor: Colors.black,
                validator: (value) {
                  if (controller.isLogin.value != 'rmPassword') {
                    if (value!.isEmpty) {
                      return controller.isLogin.value == 'login' ? '用户名/邮箱不能为空' : '用户名不能为空';
                    }
                    if (value.length < 3) {
                      return '用户名必须至少 3 个字符';
                    }
                  }
                  return null;
                },
              ),
            )),

            const SizedBox(height: 10,),

            Obx(() => Offstage(
              offstage: controller.isLogin.value == 'login' ? true : false,
              child: TextFormField(
                controller: emailController,
                decoration: inputDecoration(labelText: '邮箱'),
                cursorColor: Colors.black,
                validator: (value) {
                  if(controller.isLogin.value != 'login'){
                    if (value!.isEmpty) {
                      return '邮箱不能为空';
                    }
                    if (!RegExp(
                        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')
                        .hasMatch(value)) {
                      return '邮箱地址无效';
                    }
                  }
                  return null;
                },
              ),
            ),),

            const SizedBox(height: 10,),

            Obx(() => TextFormField(
              controller: passwordController,
              decoration: inputDecoration(
                  labelText: '密码',
                  icon: GestureDetector(
                    onTap: () => isShowPassword.toggle(),
                      child: Obx(() => Icon(
                          isShowPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility
                      ))
                  )
              ),
              cursorColor: Colors.black,
              obscureText: isShowPassword.value,
              validator: (value) {
                if (value!.isEmpty) {
                  return '密码不能为空';
                }
                if (value.length < 6) {
                  return '密码长度必须大于等于 6';
                }
                return null;
              },
            )),

            const SizedBox(height: 10,),

            Obx(() => Offstage(
              offstage: controller.isLogin.value != 'login' ? false : true,
              child: Obx(() => TextFormField(
                controller: password0Controller,
                decoration: inputDecoration(
                    labelText: '确认密码',
                    icon: GestureDetector(
                      onTap: () => isShowPassword.toggle(),
                      child: Obx(() => Icon(
                          isShowPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility
                      ))
                    )
                ),
                cursorColor: Colors.black,
                obscureText: isShowPassword.value,
                validator: (value) {
                  if (controller.isLogin.value != 'login') {
                    if (value!.isEmpty) {
                      return '密码不能为空';
                    }
                    if (value.length < 6) {
                      return '密码长度必须大于等于 6';
                    }
                    if (value != passwordController.text) {
                      return '两次填写的密码不一致!';
                    }
                  }
                  return null;
                },
              )),
            ),),

            const SizedBox(height: 10,),

            Row(
              children: [
                GestureDetector(
                  onTap: ()=>controller.isLogin.value = controller.isLogin.value =='login' ? 'register' : 'login',
                  child: Obx(() => Text(
                    controller.isLogin.value == 'login' ? '立即注册' :  controller.isLogin.value == 'register' ? '回到登录' : '',
                    style: const TextStyle(
                      color: Colors.blue
                    ),
                  ))
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                    onTap: ()=>controller.isLogin.value = controller.isLogin.value =='login' ? 'rmPassword' : 'login',
                    child: Obx(() => Text(
                      controller.isLogin.value == 'login' ? '忘记密码?' :  controller.isLogin.value == 'rmPassword' ? '回到登录' : '',
                      style: const TextStyle(
                          color: Colors.blue
                      ),
                    ))
                )
              ],
            ),

            const SizedBox(height: 10,),

            TextButton(
              onPressed: () async {
                if (loginFormKey.currentState!.validate()) {
                  // 表单验证通过
                  // Map<String,String> user = controller.isLogin.value ? {
                  //   "identifier": identifierController.text,
                  //   "password": passwordController.text
                  // } : {
                  //   "username": userNameController.text,
                  //   "email": emailController.text,
                  //   "password": passwordController.text
                  // };
                  // String message =  await controller.loginUp(controller.controller.isLogin.value ? '' : '/register', user);
                  // Get.snackbar(
                  //     '提示',
                  //     message,
                  //     snackPosition: SnackPosition.TOP,
                  //     backgroundColor: Colors.green
                  // );
                } else {
                  // 表单验证失败
                  print('表单验证失败');
                }
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
              child: Obx(() => Text(controller.isLogin.value == 'login' ? '登录' : controller.isLogin.value == 'register' ? '注册' : '确认重置',),)
            )
          ],
        ),
      ),
    );
  }
}
