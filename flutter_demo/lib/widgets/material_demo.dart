import 'package:flutter/material.dart';

//MaterialApp
class MaterialAppDemo extends StatelessWidget {
  final Widget homeWidget;
  const MaterialAppDemo(this.homeWidget, {Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', //安卓使用，切换应用显示
      debugShowCheckedModeBanner: false, //是否是调试
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.yellow,
        primarySwatch: Colors.grey, //主题色 影响整个app
        highlightColor: const Color.fromRGBO(1, 0, 0, 0), //点击
        splashColor: const Color.fromRGBO(1, 0, 0, 0.0), //弹开
      ),
      home: homeWidget, //主页面
    );
  }
}
