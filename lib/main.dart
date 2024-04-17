import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:screen_go/screen_go.dart';

import 'app/routes/app_pages.dart';
import 'platform_utils.dart';

void main() {
  runApp(
    ScreenGo(
      materialApp: true,
      builder: (context, deviceInfo) =>GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "轻松记账",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    )
  );
  if(PlatformUtils.isPc) {
    doWhenWindowReady(() {
      // const initialSize = Size(600, 450);
      // appWindow.minSize = initialSize;
      // appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}
