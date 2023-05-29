import 'package:flutter/material.dart';
import 'package:flutter_demo/tools/const.dart';

class DiscoverChildPage extends StatelessWidget {
  final String? title;
  const DiscoverChildPage({this.title, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //context上下文
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(title!),
      ),
      body: Center(
        child: Text(title!),
      ),
    );
  }
}
