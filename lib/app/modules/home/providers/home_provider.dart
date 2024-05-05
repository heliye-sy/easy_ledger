import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../home_model.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://111.229.84.51:1337/api';

    // 请求拦截
    httpClient.addRequestModifier<void>((request) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwt = prefs.getString('jwt') ?? '';
      if (jwt == '') Get.offAllNamed('login');
      request.headers['Authorization'] = 'Bearer $jwt';
      return request;
    });

    // 响应拦截
    httpClient.addResponseModifier((request, response) async {
      if (response.statusCode == 403){
        Get.snackbar(
          '提示',
          '登录过期',
            snackPosition: SnackPosition.TOP,
        );
        Get.offAllNamed('login');
      }
      return response;
    });
  }

  // 获取用户基本信息
  Future<User?> getUser() async {
    final response = await get('/users/me',query: {"populate": "avatar"});
    User? user = response.statusCode == 200 ? User.fromJson(response.body) : null;
    return user;
  }

  // 获取账单记录
  Future<Ledgers?> getLedgers(String userId, String payType, [String? page]) async {
    final response = await get(
        '/ledgers',
        query: {
          "filters[user][id][\$eq]": userId,
          "filters[payType][\$eqi]": payType
        });
    Ledgers? ledgers = response.statusCode == 200 ? Ledgers.fromJson(response.body) : null;
    return ledgers;
  }

  // 添加一条账单记录
  Future<Ledger?> addLedger(Ledger ledger, int userId) async {
    Map<String, dynamic> data = ledger.toJson();
    data['user'] = userId;
    final response = await post('/ledgers', {'data': data});
    Ledger? newLedger = response.statusCode == 200 ? Ledger.fromJson(response.body['data']) : null;
    return newLedger;
  }

  // 修改一条账单记录
  Future<Ledger?> putLedger(Ledger ledger) async {
    final response = await put('/ledgers/${ledger.id}', {'data': ledger.toJson()});
    Ledger? newLedger = response.statusCode == 200 ? Ledger.fromJson(response.body['data']) : null;
    return newLedger;
  }

  // 删除一条账单记录
  Future<Response> deleteLedgers(int id) async => await delete('/ledgers/$id');

  // 上传文件
  Future<Response> postFiles(XFile pickedFile) async {
    final response = await post(
        '/upload/',
        FormData({
          'files': MultipartFile(File(pickedFile.path), filename: pickedFile.name)
        })
    );
    return response;
  }

  // 修改用户信息
  Future<Response> putUser(User user) async {
    final response = await put('/users/${user.id}', user.toJson());
    return response;
  }
}
