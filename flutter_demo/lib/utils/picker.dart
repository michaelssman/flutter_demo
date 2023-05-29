import 'package:flutter/material.dart';

class HHPicker {
  //底部弹出视图
  static Future showModalSheet(BuildContext context, {Widget? child}) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1), //上下边距
          child: child,
        );
      },
    );
  }
}
