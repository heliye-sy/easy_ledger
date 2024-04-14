import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/login_provider.dart';

class LoginController extends GetxController {
  final loginProvider = Get.find<LoginProvider>();
  final isLogin = true.obs;

  Future<String> loginUp(String url, Map<String, String> user) async {
    Response response = await loginProvider.login(url, user);
    String message = '';
    switch (response.statusCode) {
      case 200:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', jsonDecode(response.bodyString!)['jwt']);
        message = '欢迎用户：${jsonDecode(response.bodyString!)['user']['username']}';
        Get.offAllNamed('/home');
      case 400:
        switch (jsonDecode(response.bodyString!)['error']['message']) {
          case 'Invalid identifier or password':
            message = '用户名或密码错误！';
          case 'Your account has been blocked by an administrator':
            message = '用户被封禁，请联系管理员！';
          case 'Email or Username are already taken':
            message = '邮箱或者用户名被占用！';
          default:
            message = '未知错误！请联系开发者！${response.statusCode}';
        }
      default:
        message = '未知错误！请联系开发者！${response.statusCode}';
    }
    return message;
  }
}
