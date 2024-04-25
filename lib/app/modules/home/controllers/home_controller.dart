import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_model.dart';
import '../providers/home_provider.dart';

class HomeController extends GetxController with StateMixin<List<Ledger>>{
  final userProvider = Get.find<HomeProvider>();
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

  Future<void> getUser() async {
      User? userH = await userProvider.getUser();
      //请求出错时
      if(userH == null){
        Get.offAllNamed('/login');
      }else{
        //请求成功时，显示数据
        user.value = userH;
      }
    }

  void getLedgers(String userId, String payType) async {
    //刚开始显示加载中。。
    change(null,status: RxStatus.loading());
    //执行网络请求
    List<Ledger>? ledgers = await userProvider.getLedgers(userId, payType);
    //请求出错时
    if(ledgers == null){
      change(ledgers, status: RxStatus.error('获取账单记录失败'));
    }else{
      //请求成功时，显示数据
      change(ledgers, status: RxStatus.success());
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getUser();
    if(user.value.id != 0) getLedgers(user.value.id.toString(), "weChat");
  }

  void rmJwt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    Get.offNamed('/login');
  }
}
