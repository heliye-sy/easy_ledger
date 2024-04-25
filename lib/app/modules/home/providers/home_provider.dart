import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_model.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.defaultDecoder = (map) {
    //   if (map is Map<String, dynamic>) {
    //     {
    //       if (map.containsKey('error')){
    //         return null;
    //       }
    //       return User.fromJson(map);
    //     }
    //   }
    // };

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

  // 获取用户基本信息
  Future<User?> getUser() async {
    final response = await get('/users/me',query: {"populate": "avatar"});
    User? user = response.statusCode == 200 ? User.fromJson(response.body) : null;
    return user;
  }

  // 获取账单记录
  Future<List<Ledger>?> getLedgers(String userId, String payType) async {
    final response = await get(
        '/ledgers',
        query: {
          "filters[user][id][\$eq]": userId,
          "filters[payType][\$eqi]": payType
        });
    List<Ledger>? ledgers =
    response.statusCode == 200
        ?
    (response.body['data'] as List).map((ledger) => Ledger.fromJson(ledger)).toList()
        :
    null;
    return ledgers;
  }

  Future<Response<User>> postUser(User user) async => await post('user', user);
  Future<Response> deleteUser(int id) async => await delete('user/$id');
}
