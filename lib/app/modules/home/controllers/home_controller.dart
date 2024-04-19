import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_model.dart';
import '../providers/user_provider.dart';

class HomeController extends GetxController with StateMixin<List<Ledger>>{
  final userProvider = Get.find<UserProvider>();
  var user = User(
    id: 0,
    username: '',
    email: '',
    provider: '',
    confirmed: true,
    blocked: false,
    createdAt: '',
    updatedAt: '',
  ).obs;

  void getUser() async {
    //刚开始显示加载中。。
    change(null,status: RxStatus.loading());
    //执行网络请求
    User? userR = await userProvider.getUser();
    //请求出错时
    if(userR == null){
      Get.offAllNamed('/login');
    }else{
      //请求成功时，显示数据
      user.value = userR;
      change(userR.ledgers, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void rmJwt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    Get.offNamed('/login');
  }
}
