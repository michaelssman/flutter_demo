import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //创建channel
  final MethodChannel _oneChannel = const MethodChannel('one_page');
  final MethodChannel _twoChannel = const MethodChannel('two_page');
  //创建消息监听
  final BasicMessageChannel _messageChannel = const BasicMessageChannel(
      'messageChannel', StandardMessageCodec()); //参数： 名字 解码器
  String pageIndex = 'one';

  /// 初始化
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 关心一个消息
    _messageChannel.setMessageHandler((message) {
      print('收到来自iOS的$message');
      return Future(() {});
    });

    /// 设置监听
    _oneChannel.setMethodCallHandler((call) {
      pageIndex = call.method;
      print(call.method);
      setState(() {});
      return Future(() {});
    });
    _twoChannel.setMethodCallHandler((call) {
      pageIndex = call.method;
      print(call.method);
      setState(() {});
      return Future(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: _rootPage(pageIndex),
    );
  }

  //根据pageIndex返回页面
  Widget _rootPage(String pageIndex) {
    switch (pageIndex) {
      case 'one':
        return Scaffold(
          appBar: AppBar(
            title: Text(pageIndex),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _oneChannel.invokeMapMethod('exit');
                },
                child: Text(pageIndex),
              ),
              TextField(
                onChanged: (String str) {
                  _messageChannel.send(str); //给iOS发消息
                },
              )
            ],
          ),
        );
      case 'two':
        return Scaffold(
          appBar: AppBar(
            title: Text(pageIndex),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                _twoChannel.invokeMapMethod('exit');
              },
              child: Text(pageIndex),
            ),
          ),
        );
      default:
        return Scaffold(
          appBar: AppBar(
            title: Text(pageIndex),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                const MethodChannel('default_page').invokeMapMethod('exit');
              },
              child: Text(pageIndex),
            ),
          ),
        );
    }
  }
}
