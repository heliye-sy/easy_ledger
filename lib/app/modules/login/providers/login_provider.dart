import 'package:get/get.dart';

class LoginProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://1.92.122.231:1337/api/auth';
    // 响应拦截
    httpClient.addResponseModifier((request, response) async {
      return response;
    });
  }

  //登录和注册
  Future<Response> login(String url, Map<String, String> user) async {
    final response = await post('/local$url', user);
    return response;
  }

  //验证邮箱
  Future<Response> email(String code) async {
    final response = await get('/email-confirmation',query: {'confirmation': code});
    return response;
  }
}
