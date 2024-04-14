import 'package:flutter/material.dart';
import 'package:easy_ledger/platform_utils.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class CustomWindow extends StatelessWidget {
  const CustomWindow({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {

    if(PlatformUtils.isPc) {
      return WindowBorder(
        width: 0,
        color: Colors.black,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.orange, Colors.yellow],
                ),
              ),
              child: WindowTitleBarBox(
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
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange, Colors.yellow],
                  ),
                ),
                child: body,
              ),
            )
          ],
        ),
      );
    }
    else{
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.orange, Colors.yellow],
          ),
        ),
        child: body,
      );
    }
  }
}
