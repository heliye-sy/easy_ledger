import 'package:get/get.dart';

class LoginProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://111.229.84.51:1337/api/auth';
    // 响应拦截
    httpClient.addResponseModifier((request, response) async {
      return response;
    });
  }

  //登录和注册和忘记密码
  Future<Response> lrr(String url, Map<String, String> q) async {
    final response = await post(url, q);
    return response;
  }

  //验证邮箱
  Future<Response> email(String code) async {
    final response = await get('/email-confirmation',query: {'confirmation': code});
    return response;
  }
}
