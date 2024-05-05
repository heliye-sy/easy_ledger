import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/home_controller.dart';

class DrawerView extends GetView<HomeController> {
  const DrawerView({super.key});
  @override
  Widget build(BuildContext context) {
    const canvasColor = Color(0xFF5B88D0);
    const scaffoldBackgroundColor = Color(0xFF464667);
    const accentCanvasColor = Color(0xFF3E3E61);
    const white = Colors.white;
    final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
    final divider = Divider(color: white.withOpacity(0.3), height: 1);

    return Obx(() => SidebarX(
      controller: SidebarXController(
          selectedIndex: controller.selectedIndex.value,
          extended: true
      ),
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      headerBuilder: (context, extended) => Container(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final picker = ImagePicker(); // 创建ImagePicker实例
                final XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.gallery); // 从图库中选择图像
                if (pickedFile != null) {
                  controller.setAvatar(pickedFile);
                }
              },
              child: Obx(() => controller.user.value.avatar != null
                  ?
              FadeInImage(
                placeholder: Image.asset('assets/images/avatar.png').image,
                image: NetworkImage('http://111.229.84.51:1337${controller.user.value.avatar?.url}'),
              )
                  :
              Image.asset(
                  'assets/images/avatar.png'
              )),
            ),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.user.value.username),
                IconButton(
                    onPressed: () {
                      InputDecoration inputDecoration(String labelText) {
                        var customBorder = OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(style: BorderStyle.none)
                        );
                        return InputDecoration(
                          labelText: labelText,
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
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
                      final formKey = GlobalKey<FormState>();
                      Get.dialog(
                          AlertDialog(
                              title: const Text('修改用户'),
                              content: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      initialValue: controller.user.value.username,
                                      decoration: inputDecoration('用户名'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '用户名不能为空';
                                        }
                                        if (value.length < 3) {
                                          return '用户名必须至少 3 个字符';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => controller.user.value.username = value!,
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      initialValue: controller.user.value.balance.toString(),
                                      decoration: inputDecoration('剩余总钱财'),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '剩余总钱财不能为空';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => controller.user.value.balance = double.parse(value!),
                                    ),
                                    const SizedBox(height: 20),
                                    TextButton(
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            formKey.currentState!.save();
                                            controller.setUser();
                                            Get.back();
                                          }
                                        },
                                        style: ButtonStyle(
                                          //背景颜色
                                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                                            //设置按下时的背景颜色
                                            if (states.contains(MaterialState.pressed)) {
                                              return Colors.blue[200];
                                            }
                                            return Colors.blue;
                                          }),
                                        ),
                                        child: const Text(
                                          '提交',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),

                          )
                      );
                    },
                    icon: const Icon(Icons.create)
                )
              ],
            )),
            Obx(() => Text('剩余总钱财：${controller.user.value.balance}'))
          ],
        ),
      ),
      items: [
        SidebarXItem(
            onTap: () => controller.getLedgers('weChat'),
            icon: Icons.wechat,
            label: '微信'
        ),
        SidebarXItem(
            onTap: () => controller.getLedgers('Alipay'),
            icon: Ionicons.logo_alipay,
            label: '支付宝'
        ),
        SidebarXItem(
            onTap: () => controller.getLedgers('other'),
            icon: Icons.menu,
            label: '其他'
        ),
        SidebarXItem(
          icon: Icons.exit_to_app,
          label: '退出登录',
          selectable: false,
          onTap: () => controller.rmJwt(),
        )
      ],
      footerDivider: divider,
    ));
  }
}
