import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/widgets/scaffold_demo.dart';

class MethodChannelDemo extends StatefulWidget {
  const MethodChannelDemo({Key? key}) : super(key: key);

  @override
  State<MethodChannelDemo> createState() => _MethodChannelDemoState();
}

class _MethodChannelDemoState extends State<MethodChannelDemo> {
  File? _avatarFile;
  final MethodChannel _methodChannel = const MethodChannel('mine_page/method');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodChannel.setMethodCallHandler((call) {
      if (call.method == 'imagePath') {
        print(call.arguments);
        String imagePath = call.arguments.toString().substring(7);
        setState(() {
          _avatarFile = File(imagePath);
        });
      }
      return Future(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return HHScaffold(
      Container(
        height: 200,
        color: Colors.white,
        child: Container(
          margin:
              const EdgeInsets.only(top: 100, bottom: 20, left: 20, right: 10),
          // color: Colors.red,
          child: Row(
            children: [
              //头像
              GestureDetector(
                onTap: () {
                  _methodChannel.invokeMapMethod('picture'); //通知原生
                },
                child: Container(
                  width: 70,
                  height: 70,
                  //圆角
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: _avatarFile == null
                              ? const AssetImage('images/Hank.png')
                                  as ImageProvider
                              : FileImage(_avatarFile!),
                          //裁剪
                          fit: BoxFit.cover)),
                ),
              ),
              //右边的部分,包一个Expanded，懒得算了。
              Expanded(
                  child: Container(
                // color: Colors.red,
                // margin:
                //     EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
                // width: MediaQuery.of(context).size.width - 100,
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 35,
                      child: const Text(
                        '交互',
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ), //昵称
                    Container(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            '点击头像和原生交互',
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                          Image(
                            image: AssetImage('images/icon_right.png'),
                            width: 15,
                          )
                        ],
                      ),
                    ), //微信号+箭头
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
      title: 'channel',
    );
  }
}
