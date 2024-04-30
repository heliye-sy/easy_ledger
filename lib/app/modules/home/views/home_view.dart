import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:screen_go/extensions/orienation_type_value.dart';


import '../controllers/home_controller.dart';
import '../../window_wiget.dart';
import 'drawer_view.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Widget appBar = AppBar(
      backgroundColor: Colors.blueAccent,
      leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      title: Obx(() => Text(controller.title.value),),
      centerTitle: true,
      titleTextStyle: const TextStyle(
          color: Colors.white
      ),
    );
    return Scaffold(
      body: CustomWindow(
        body: Scaffold(
          key: scaffoldKey,
          appBar: otv(context: context, portrait: appBar, landscape: null),

          drawer: const DrawerView(),

          body: Row(
            children: [
              otv(context: context, portrait: const SizedBox(), landscape: const DrawerView()),
              Expanded(
                child: controller.obx(
                      (ledgers) {
                        // DateTime time = DateTime();
                        return ListView(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          children: ledgers!.data.map((ledger) {
                            return Column(
                              children: [

                                Card(
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(ledger.name),
                                          leading: Text(ledger.date.toString()),
                                          subtitle: Text(ledger.remark ?? ''),
                                          trailing: Text(ledger.amount),
                                        ),
                                        ButtonBar(
                                          children: [
                                            TextButton.icon(
                                                onPressed: () {
                                                  Get.dialog(
                                                    AlertDialog(
                                                      title: const Text('删除账单'),
                                                      content: const Text('你确定要删除这条记录吗？'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            controller.deleteLedger(ledger.id);
                                                            Get.back(); // 返回true作为确认结果
                                                          },
                                                          child: const Text('确定'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.back(result: false); // 返回false作为取消结果
                                                          },
                                                          child: const Text('取消'),
                                                        ),
                                                      ],
                                                    ),
                                                  ).then((value) {
                                                    if (value != null && value == true) {
                                                      // 用户点击了确认按钮
                                                    } else {
                                                      // 用户点击了取消按钮或关闭了对话框
                                                    }
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                label: const Text('删除')
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                )
                              ],
                            );
                          }).toList(),
                        );
                      },
                  onEmpty: const Center(child:Text('没有数据')), //空数据显示
                  onError: (error) => Center(child: Text(error!)), //出错界面显示
                ),
              ),
            ],
          ),
          floatingActionButton:  FloatingActionButton(
            onPressed: () {
              final addFormKey = GlobalKey<FormState>();
              Get.dialog(
                  AlertDialog(
                    title: const Text('添加一条账单记录'),
                    content: Form(
                      key: addFormKey,
                      child: Column(
                        children: [
                          TextFormField(

                          )
                        ],
                      ),
                    ),
                  )
              );
            },
            tooltip: '添加',
            child: const Icon(Icons.add),
          ),
        )
      ),
    );

  }
}

