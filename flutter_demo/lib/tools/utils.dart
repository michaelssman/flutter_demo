import 'package:flutter/material.dart';

void navigatorPush(BuildContext context, Widget widget) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) => widget));

  // Navigator.push(
  //     context, MaterialPageRoute(builder: (BuildContext context) => widget));
}
