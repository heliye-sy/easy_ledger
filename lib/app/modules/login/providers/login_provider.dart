import 'package:get/get.dart';

class LoginProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://1.92.122.231:1337/api';
    // 响应拦截
    httpClient.addResponseModifier((request, response) async {
      return response;
    });
  }

  //登录和注册
  Future<Response> login(String url, Map<String, String> user) async {
    final response = await post(url, user);
    return response;
  }
}
