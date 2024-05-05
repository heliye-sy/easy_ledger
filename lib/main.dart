import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:screen_go/screen_go.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/routes/app_pages.dart';
import 'utils/platform_utils.dart';

void main() {
  runApp(
    ScreenGo(
      materialApp: true,
      builder: (context, deviceInfo) =>GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "轻松记账",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,//是Flutter的一个本地化委托，用于提供Material组件库的本地化支持
          GlobalWidgetsLocalizations.delegate,//用于提供通用部件（Widgets）的本地化支持
          GlobalCupertinoLocalizations.delegate,//用于提供Cupertino风格的组件的本地化支持
        ],
        supportedLocales: const [
          Locale('zh', 'CN'),// 支持的语言和地区
        ],
      ),
    )
  );
  if(PlatformUtils.isPc) {
    doWhenWindowReady(() {
      const initialSize = Size(1150, 600);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = "轻松记账";
      appWindow.show();
    });
  }
}
