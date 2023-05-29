import 'dart:math';

import 'package:flutter/material.dart';

class KeyDemo extends StatefulWidget {
  const KeyDemo({Key? key}) : super(key: key);

  @override
  _KeyDemoState createState() => _KeyDemoState();
}

class _KeyDemoState extends State<KeyDemo> {
  List<Widget> items = [
    const StfulItem(
      '1111',
      key: ValueKey(111),
    ),
    const StfulItem(
      '2222',
      key: ValueKey(222),
    ),
    const StfulItem(
      '3333',
      key: ValueKey(333),
    )
    // StlItem('1111'),
    // StlItem('2222'),
    // StlItem('3333')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('keyDemo'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center, //主轴
        children: items,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () {
          setState(() {
            items.removeAt(0); //删除第一个

            // /// 删除时同步创建一个Widget，是否会创建Element？
            // /// 通过断点调试
            // items.add(const StfulItem('444'));
          });
        },
      ), //悬浮按钮
    );
  }
}

class StfulItem extends StatefulWidget {
  final String title;
  const StfulItem(this.title, {Key? key}) : super(key: key);

  @override
  _StfulItemState createState() => _StfulItemState();
}

class _StfulItemState extends State<StfulItem> {
  final color = Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),
      Random().nextInt(256), 1.0); //随机色
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Text(widget.title),
      color: color,
    );
  }
}

class StlItem extends StatelessWidget {
  final String title;

  StlItem(this.title, {Key? key}) : super(key: key);

  final color = Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),
      Random().nextInt(256), 1.0); //随机色
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Text(title),
      color: color,
    );
  }
}
