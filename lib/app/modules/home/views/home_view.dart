import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:screen_go/extensions/responsive_nums.dart';
import 'package:sidebarx/sidebarx.dart';


import '../controllers/home_controller.dart';
import '../../window_wiget.dart';
import 'drawer_view.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomWindow(
        body: Scaffold(
          key: scaffoldKey,
          appBar: 100.w < 100.h
              ?
          AppBar(
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
          )
              :
          null,

          drawer: const DrawerView(),

          body: Row(
            children: [
              if(100.w > 100.h) const DrawerView(),
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
                      return controller.obx((ledgers) => ListView(
                        padding: const EdgeInsets.only(top: 10),
                        children: ledgers!.map((e) => Slidable(
                            endActionPane: ActionPane(
                              // 动作是一个用于控制窗格动画方式的小部件。
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: const [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: '删除',
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
                                leading: const Icon(Icons.wechat),
                                title: Text(e.name),
                                subtitle: Text(e.remark ?? ''),
                                trailing: Text(mio[e.category]! + e.amount.toString()),
                              ),
                            )
                        )).toList(),
                      ));
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
