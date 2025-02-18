import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:screen_go/extensions/orienation_type_value.dart';

import '../controllers/home_controller.dart';
import '../../window_wiget.dart';
import 'drawer_view.dart';
import 'form_view.dart';

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
                        return ListView(
                          controller: controller.scrollController,
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
                                                  controller.ledgerType.value = 'put';
                                                  controller.ledger.value = ledger;
                                                  Get.dialog(
                                                      const AlertDialog(
                                                      title: Text('修改账单'),
                                                      content: FormView(),
                                                    )
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.settings_rounded,
                                                  color: Colors.green,
                                                ),
                                                label: const Text('修改')
                                            ),
                                            TextButton.icon(
                                                onPressed: () {
                                                  Get.dialog(
                                                    AlertDialog(
                                                      title: const Text('删除账单'),
                                                      content: const Text('你确定要删除这条记录吗？'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            controller.delFromString(ledger.amount);
                                                            controller.deleteLedger(ledger.id);
                                                            controller.setUser();
                                                            Get.back();
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
              InputDecoration inputDecoration(String labelText) {
                var customBorder = OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(style: BorderStyle.none)
                );
                return InputDecoration(
                  labelText: labelText,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  border: customBorder,
                  enabledBorder:customBorder,
                  focusedBorder:customBorder,
                  focusedErrorBorder: customBorder,
                  errorBorder: customBorder,
                  filled: true,
                  fillColor: const Color(0xffF6F6F8),
                  //隐藏下划线
                  //border: InputBorder.none,
                  hintStyle: const TextStyle(fontSize: 15, color: Color(0xffAEAEAE)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                );
              }
              final formKey = GlobalKey<FormState>();
              if (controller.user.value.balance == null) {
                Get.dialog(
                    AlertDialog(
                      title: const Text('未设置初始金额'),
                      content: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: controller.user.value.balance.toString(),
                              decoration: inputDecoration('初始金额'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '初始金额不能为空';
                                }
                                return null;
                              },
                              onSaved: (value) => controller.user.value.balance = double.parse(value!),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    controller.setUser();
                                    Get.back();
                                  }
                                },
                                style: ButtonStyle(
                                  //背景颜色
                                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                                    //设置按下时的背景颜色
                                    if (states.contains(MaterialState.pressed)) {
                                      return Colors.blue[200];
                                    }
                                    return Colors.blue;
                                  }),
                                ),
                                child: const Text(
                                  '确定',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    )
                );
              } else {
                controller.ledger.value.reset();
                controller.ledgerType.value = 'add';
                Get.dialog(
                    const AlertDialog(
                      title: Text('添加一条账单记录'),
                      content: FormView(),
                    )
                );
              }
            },
            tooltip: '添加',
            child: const Icon(Icons.add),
          ),
        )
      ),
    );

  }
}

