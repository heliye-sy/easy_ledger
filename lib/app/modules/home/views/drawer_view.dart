import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:ionicons/ionicons.dart';

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

    return SidebarX(
      controller: SidebarXController(
          selectedIndex: 0,
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
            Obx(() => controller.user.value.avatar != null
                ?
            FadeInImage(
              placeholder: Image.asset('assets/images/avatar.png').image,
              image: NetworkImage('http://111.229.84.51:1337${controller.user.value.avatar}'),
            )
                :
            Image.asset(
                'assets/images/avatar.png'
            )),
            Obx(() => Text(controller.user.value.username)),
            Obx(() => Text('剩余总钱财：${controller.user.value.balance}'))
          ],
        ),
      ),
      items: [
        SidebarXItem(
            onTap: () => controller.getLedgers(controller.user.value.id.toString(), 'weChat'),
            icon: Icons.wechat,
            label: '微信'
        ),
        SidebarXItem(
            onTap: () => controller.getLedgers(controller.user.value.id.toString(), 'Alipay'),
            icon: Ionicons.logo_alipay,
            label: '支付宝'
        ),
        SidebarXItem(
            onTap: () => controller.getLedgers(controller.user.value.id.toString(), 'other'),
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
    );
  }
}
