import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_model.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        {
          if (map.containsKey('error')){
            return null;
          }
          return User.fromJson(map);
        }
      }
    };
    httpClient.baseUrl = 'http://111.229.84.51:1337/api';
    // 请求拦截
    httpClient.addRequestModifier<void>((request) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwt = prefs.getString('jwt') ?? '';
      if (jwt == '') Get.offAllNamed('login');
      request.headers['Authorization'] = 'Bearer $jwt';
      return request;
    });
  }

  Future<User?> getUser() async {
    final response = await get('/users/me',query: {'populate': '*'});
    return response.body;
  }

  Future<Response<User>> postUser(User user) async => await post('user', user);
  Future<Response> deleteUser(int id) async => await delete('user/$id');
}
