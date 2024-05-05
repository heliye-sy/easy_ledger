import 'package:flutter/material.dart';
import 'package:easy_ledger/utils/platform_utils.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class CustomWindow extends StatelessWidget {
  const CustomWindow({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    if(PlatformUtils.isPc) {
      return WindowBorder(
        width: 0,
        color: Colors.grey,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Container(
                color: Colors.blue,
                child: Row(
                  children: [
                    Expanded(child: MoveWindow()),
                    Row(
                      children: [
                        MinimizeWindowButton(),
                        appWindow.isMaximized ? RestoreWindowButton() : MaximizeWindowButton(),
                        CloseWindowButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: body,
            )
          ],
        ),
      );
    }
    else{
      return body;
    }
  }
}
