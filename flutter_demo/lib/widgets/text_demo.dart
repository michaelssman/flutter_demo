import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/scaffold_demo.dart';

//自定义widget
//stateFul 有状态(会变化，例如按钮) stateless无状态（不会变）
class TextDemo extends StatelessWidget {
  const TextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //build返回widget
    // TODO: implement build
    //Center和Text是两个widget
    return const HHScaffold(
      TextDemo1(),
      title: 'Text',
    );
  }
}

//文字样式
class TextDemo1 extends StatelessWidget {
  final TextStyle _textStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold, //FontWeight是个类
    fontStyle: FontStyle.italic, //斜体
    color: Colors.red, //Colors是个类
  );

  final String _teacher = 'Michael';
  final String _title = 'Flutter进阶';

  const TextDemo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      //Text的构造方法，下面都是Text的成员属性，只能赋值一次，在别的地方不能修改。
      //title
      '<$_title> -- $_teacher。姐夫圣诞快乐附近的路口；法兰克福家里快放假了；房价多少了；房价的快乐分会更加好盖好科技股和奋斗科技护肤隔开；发赶快发货感觉快疯了和姑父健康联合国将宽带发了个',
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr, //文字方向 从左到右 必须得有一个方向
      style: _textStyle,
      maxLines: 3,
      overflow: TextOverflow.ellipsis, //显示省略号
    );
  }
}

class RichTextDemo extends StatelessWidget {
  const RichTextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //富文本
    return RichText(
      text: const TextSpan(
        text: '《Flutter高级进阶班》',
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: '--',
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: 'Jordan',
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
