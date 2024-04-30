import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_model.dart';
import '../providers/home_provider.dart';

class HomeController extends GetxController with StateMixin<Ledgers>{
  final homeProvider = Get.find<HomeProvider>();
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
  var title = '微信'.obs;
  var selectedIndex = 0.obs;
  var ledger = Ledger(
      id: 0,
      name: '',
      amount: '',
      date: DateTime.now(),
      payType: '',
      createdAt: '',
      updatedAt: ''
  );

  Future<void> getUser() async {
      User? userH = await homeProvider.getUser();
      //请求出错时
      if(userH == null){
        Get.offAllNamed('/login');
      }else{
        //请求成功时，显示数据
        user.value = userH;
      }
    }

  void getLedgers(String payType) async {
    switch (payType){
      case 'weChat':
        title.value = '微信';
        selectedIndex.value = 0;
      case 'Alipay':
        title.value = '支付宝';
        selectedIndex.value = 1;
      case 'other':
        title.value = '其他';
        selectedIndex.value = 2;
      default:
        title.value = '无';
    }
    //刚开始显示加载中。。
    change(null,status: RxStatus.loading());
    //执行网络请求
    Ledgers? ledgers = await homeProvider.getLedgers(user.value.id.toString(), payType);
    //请求出错时
    if(ledgers == null){
      change(ledgers, status: RxStatus.error('获取${title.value}账单失败'));
    }else if (ledgers.data.isNotEmpty){
      //请求成功时，显示数据
      change(ledgers, status: RxStatus.success());
    } else {
      change(ledgers, status: RxStatus.empty());
    }
  }

  void addLedger(Ledger ledger) async {
    await homeProvider.addLedger(ledger);
  }

  void deleteLedger(int id) async {
    await homeProvider.deleteLedgers(id);
    state?.data.removeWhere((ledger) => ledger.id == id);
    change(state, status: RxStatus.success());
  }

  @override
  void onInit() async {
    super.onInit();
    await getUser();
    if(user.value.id != 0) getLedgers("weChat");
  }

  void rmJwt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    Get.offNamed('/login');
  }
}
