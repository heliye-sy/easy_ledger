import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:screen_go/extensions/responsive_nums.dart';
import 'package:screen_go/extensions/orienation_type_value.dart';
import 'package:sidebarx/sidebarx.dart';


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
      title: const Text(
          '主页'
      ),
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
                child: Center(
                  child: AnimatedBuilder(
                    animation: SidebarXController(
                        selectedIndex: 0,
                        extended: true
                    ),
                    builder: (BuildContext context, Widget? child) {
                      Map<String, String> mio = {
                        'out': '-',
                        'in': '+'
                      };
                      return controller.obx(
                              (ledgers) => ListView(
                                padding: const EdgeInsets.only(top: 10),
                                children: ledgers!.map((ledger) => Slidable(
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dismissible: DismissiblePane(onDismissed: () {}),

                                      children: [
                                        TextButton.icon(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          label: const Text(
                                            '删除'
                                          ),
                                          onPressed: () => controller.deleteLedgers(ledger.id),
                                        ),
                                        SlidableAction(
                                          onPressed: doNothing,
                                          backgroundColor: Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          icon: Icons.settings_backup_restore,
                                          label: '修改',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFF5B88D0),
                                        boxShadow: const [BoxShadow()],
                                      ),
                                      child: ListTile(
                                        // leading: Text(ledger.date),
                                        leading: Text(ledger.id.toString()),
                                        title: Text(ledger.name),
                                        subtitle: Text(ledger.remark ?? ''),
                                        trailing: Text(mio[ledger.category]! + ledger.amount.toString()),
                                      ),
                                    )
                                )).toList(),
                              ),
                        onEmpty: const Text('没有数据'), //空数据显示
                        onError: (error) => Text(error!), //出错界面显示
                      );
                      },
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );

  }
}

void doNothing(BuildContext context) {}
