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
        Map<String, dynamic> body = jsonDecode(response.bodyString!);
        if(body.containsKey('jwt')) {
          await prefs.setString('jwt', body['jwt']);
          message =
              '欢迎用户：${body['user']['username']}';
          Get.offAllNamed('/home');
        }
      case 400:
        switch (jsonDecode(response.bodyString!)['error']['message']) {
          case 'Invalid identifier or password':
            message = '用户名/邮箱或密码错误！';
          case 'Your account has been blocked by an administrator':
            message = '用户被封禁，请联系管理员！';
          case 'Your account email is not confirmed':
            message = '您的帐户电子邮件还未验证！';
          case 'Email or Username are already taken':
            message = '邮箱或者用户名已被使用！';
          default:
            message = '未知错误！请联系开发者！${response.statusCode}';
        }
      default:
        message = '未知错误！请联系开发者！${response.statusCode}';
    }
    return message;
  }
}
