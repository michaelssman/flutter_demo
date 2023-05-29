import 'package:flutter/material.dart';

/// Center
/// Text
/// RichText

//自定义widget
//stateFul 有状态(会变化，例如按钮) stateless无状态（不会变）
class CenterDemo extends StatelessWidget {
  const CenterDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //build返回widget
    // TODO: implement build
    //Center和Text是两个widget
    return const Center(
      //child相当于subView  是Center的一个属性
      child: BaseWidgetDemo(),
    );
  }
}

class BaseWidgetDemo extends StatelessWidget {
  const BaseWidgetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.red,
            child: const Icon(
              Icons.add,
              size: 45,
            ),
            padding: EdgeInsets.all(30), //内边距
            margin: EdgeInsets.all(20), //外边距
            height: 200,
          )
        ],
      ),
    );
  }
}
