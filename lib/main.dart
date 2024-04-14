import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'app/routes/app_pages.dart';
import 'platform_utils.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "轻松记账",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
  if(PlatformUtils.isPc) {
    doWhenWindowReady(() {
      const initialSize = Size(500, 1000);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}
