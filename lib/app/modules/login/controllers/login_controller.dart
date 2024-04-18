import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/login_provider.dart';

class LoginController extends GetxController {
  final loginProvider = Get.find<LoginProvider>();
  final isLogin = 'login'.obs;

  //登录和注册
  Future<String> lrr(String url, Map<String, String> q) async {
    Response response = await loginProvider.lrr(url, q);
    String message = '';
    switch (response.statusCode) {
      case 200:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> body = jsonDecode(response.bodyString!);
        if(body.containsKey('jwt')) {
          await prefs.setString('jwt', body['jwt']);
          message = '欢迎用户：${body['user']['username']}';
          Get.offAllNamed('/home');
        } else if (body.containsKey('ok')) {
          message = '令牌已发送，请前往邮箱';
        } else {
          message = 'r';
        }
      case 400:
        switch (jsonDecode(response.bodyString!)['error']['message']) {
          case 'Invalid identifier or password':
            message = '用户名/邮箱或密码错误！';
          case 'Your account has been blocked by an administrator':
            message = '用户被封禁，请联系管理员！';
          case 'Your account email is not confirmed':
            message = '您的帐户电子邮箱还未验证！';
          case 'Email or Username are already taken':
            message = '邮箱或者用户名已被使用！';
          case 'email is a required field':
            message = '邮箱不能为空！';
          case 'email must be a valid email':
            message = '邮箱地址无效！';
          default:
            message = '未知错误！请联系开发者!';
            print(response.body);
        }
      default:
        message = '未知错误！请联系开发者！';
        print(response.body);
    }
    return message;
  }

  //验证邮箱
  Future<int?> email(String code) async {
    Response response = await loginProvider.email(code);
    return response.statusCode;
  }

}
