import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:easy_ledger/utils/dart_date.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class FormView extends GetView<HomeController> {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          Obx(() => TextFormField(
            initialValue: controller.ledger.value.name,
            decoration: inputDecoration('交易对象'),
            cursorColor: Colors.black,
            onSaved: (value) => controller.ledger.update((val) => val!.name = value!),
            validator: (value) {
              if (value!.isEmpty) {
                return '交易对象不能为空';
              }
              return null;
            },
          )),
          const SizedBox(height: 20),
          Obx(() => TextFormField(
            initialValue: controller.ledger.value.amount,
            decoration: inputDecoration('交易金额'),
            cursorColor: Colors.black,
            validator: (value) {
              if (value!.isEmpty) {
                return '交易金额不能为空';
              }
              if (!value.contains('-') && !value.contains('+')) {
                return '必须要有+或者-来表示支出还是收入';
              }
              return null;
            },
            onSaved: (value) {
              if (controller.ledgerType.value == 'put') controller.delFromString(controller.ledger.value.amount);
              controller.ledger.update((val) => val!.amount = value!);
            }
          )),
          const SizedBox(height: 20),
          Obx(() => TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: controller.ledger.value.date,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(5000),
                );
                if (picked != null) {
                  controller.ledger.update((val) => val!.date = val.date.setYear(picked.year,picked.month,picked.day));
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: Text(
                '交易日期：${DateFormat('yyyy-MM-dd').format(controller.ledger.value.date)}',
                style: const TextStyle(
                  color: Colors.black
                ),
              )
          )),
          const SizedBox(height: 20),
          Obx(() => TextButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(controller.ledger.value.date),
                );
                if (picked != null) {
                  controller.ledger.update((val) => val!.date = val.date.setHour(picked.hour,picked.minute));
                }},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: Text(
                '交易时间：${DateFormat('HH:mm').format(controller.ledger.value.date)}',
                style: const TextStyle(
                    color: Colors.black
                ),
              )
          )),
          const SizedBox(height: 20),
          const Text('交易方式'),
          Obx(() => DropdownButtonFormField(
            value: controller.ledger.value.payType,
            hint: const Text('交易方式'),
            items: const [
              DropdownMenuItem(value: 'weChat',child: Text('微信'),),
              DropdownMenuItem(value: 'Alipay',child: Text('支付宝'),),
              DropdownMenuItem(value: 'other',child: Text('其他'),)
            ],
            onChanged: (value) {
              controller.ledger.update((val) => val?.payType = value!);
            },
          )),
          const SizedBox(height: 20),
          Obx(() => TextFormField(
            initialValue: controller.ledger.value.remark,
            decoration: inputDecoration('交易详情'),
            cursorColor: Colors.black,
            maxLength: null,
            keyboardType: TextInputType.multiline,
            onSaved: (value) => controller.ledger.update((val) => val!.remark = value!),
          )),
          const SizedBox(height: 20),
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  switch (controller.ledgerType.value) {
                    case 'add':
                      controller.addFromString();
                      controller.addLedger();
                      controller.setUser();
                    case 'put':
                      controller.addFromString();
                      controller.putLedger();
                      controller.setUser();
                  }
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
                '提交',
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          )
        ],
      ),
    );
  }
}
