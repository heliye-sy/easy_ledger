import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_model.dart';
import '../providers/user_provider.dart';

class HomeController extends GetxController with StateMixin<User> {
  final userProvider = Get.find<UserProvider>();

  void getUser() async {
    //刚开始显示加载中。。
    change(null,status: RxStatus.loading());
    //执行网络请求
    User? user = await userProvider.getUser();
    //请求出错时
    if(user == null){
      change(null,status: RxStatus.error('登录失效，请点击我重新登录'));
    }else{
      //请求成功时，显示数据
      User article= user;
      change(article,status: RxStatus.success());
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
