import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  var ledgerType = ''.obs;
  var ledger = Ledger(
      id: 0,
      name: '',
      amount: '',
      date: DateTime.now(),
      remark: '',
      payType: 'weChat',
      createdAt: '',
      updatedAt: ''
  ).obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(onScroll);
    await getUser();
    if(user.value.id != 0) getLedgers("weChat");
  }

  // 获取用户基本信息
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

  // 获取账单记录
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

  // 添加一条账单记录
  void addLedger() async {
    await homeProvider.addLedger(ledger.value, user.value.id);
    ledger.value = Ledger(
        id: 0,
        name: '',
        amount: '',
        date: DateTime.now(),
        remark: '',
        payType: 'weChat',
        createdAt: '',
        updatedAt: ''
    );
    getLedgers('weChat');
  }

  // 删除一条账单记录
  void deleteLedger(int id) async {
    await homeProvider.deleteLedgers(id);
    getLedgers('weChat');
  }

  // 添加账单记录时对总金额修改
  void addFromString() {
    switch (ledger.value.amount[0]) {
      case "+":
        user.value.balance = user.value.balance! + (num.tryParse(ledger.value.amount.substring(1)) ?? 0);
      case "-":
        user.value.balance = user.value.balance! - (num.tryParse(ledger.value.amount.substring(1)) ?? 0);
    }
  }

  // 删除账单记录时对总金额修改
  void delFromString(String amount) {
    switch (amount[0]) {
      case "+":
        user.value.balance = user.value.balance! - (num.tryParse(amount.substring(1)) ?? 0);
      case "-":
        user.value.balance = user.value.balance! + (num.tryParse(amount.substring(1)) ?? 0);
    }
  }

  // 修改一条账单记录
  void putLedger() async {
    await homeProvider.putLedger(ledger.value);
    getLedgers('weChat');
  }

  // 修改头像
  void setAvatar(XFile pickedFile) async {
    var response = await homeProvider.postFiles(pickedFile);
    user.value.avatar?.id = response.body[0]['id'];
    setUser();
  }

  // 修改用户信息
  void setUser() async {
    await homeProvider.putUser(user.value);
    await getUser();
  }

  // 滑动更新
  Future<void> onScroll() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      String payType = '';
      switch (selectedIndex.value) {
        case 0:
          payType = 'weChat';
        case 1:
          payType = 'Alipay';
        case 2:
          payType = 'other';
        default:
      }
      if (state!.meta.page < state!.meta.pageCount) {
        //执行网络请求
        Ledgers? ledgers = await homeProvider.getLedgers(user.value.id.toString(), payType, state?.meta.page);
        //请求出错时
        if(ledgers == null){
          change(ledgers, status: RxStatus.error('获取${title.value}账单失败'));
        }else if (ledgers.data.isNotEmpty){
          //请求成功时
          state?.data.addAll(ledgers.data);
          state?.meta = ledgers.meta;
        }
      }
    }
  }

  // 退出登录
  void rmJwt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    Get.offNamed('/login');
  }
}
