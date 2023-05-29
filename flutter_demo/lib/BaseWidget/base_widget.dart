import 'package:flutter/material.dart';

//分割线
Widget lineWidget() {
  return Row(
    children: <Widget>[
      Container(width: 50, height: 0.5, color: Colors.white), //左
      Container(height: 0.5, color: Colors.grey) //右
    ],
  );
}

//分割块
Widget sizeBoxWidget() {
  return const SizedBox(
    height: 10,
  );
}

//组头
Widget listViewSection(String? title) {
  return SizedBox(
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(title ?? '')],
        ),
      ],
    ),
  );
}
