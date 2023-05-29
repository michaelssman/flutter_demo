import 'package:flutter/material.dart';
import 'package:flutter_demo/tools/const.dart';

/// Scaffold导航栏

class ScaffoldDemo extends StatefulWidget {
  const ScaffoldDemo({Key? key}) : super(key: key);

  @override
  State<ScaffoldDemo> createState() => _ScaffoldDemoState();
}

class _ScaffoldDemoState extends State<ScaffoldDemo> {
  //下拉框item
  Widget _buildPopupMenuItem(String imgAss, String title) {
    return Row(
      children: [
        Image(
          image: AssetImage(imgAss),
          width: 20,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold也是一个Widget 里面有appBar
      backgroundColor: Colors.white,
      appBar: AppBar(
        //导航栏 不写就不显示导航栏
        backgroundColor: themeColor, //导航栏背景色
        title: const Text('Scaffold'), //导航栏标题
        centerTitle: true, //安卓 切换应用时显示
        elevation: 0.0, //去除导航栏底部的条
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              color: const Color.fromRGBO(1, 1, 1, 0.65),
              offset: const Offset(0, 60.0), //下拉框位置
              child: const Image(
                image: AssetImage('images/圆加.png'),
                width: 25,
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                      child: _buildPopupMenuItem('images/摇一摇.png', '发起群聊')),
                  PopupMenuItem(
                      child: _buildPopupMenuItem('images/摇一摇.png', '添加朋友')),
                  PopupMenuItem(
                      child: _buildPopupMenuItem('images/摇一摇.png', '扫一扫')),
                  PopupMenuItem(
                      child: _buildPopupMenuItem('images/摇一摇.png', '收付款')),
                ];
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              print('点击按钮');
            },
            child: Container(
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.red,
      ), //MyWidget父部件是body。开发界面是放到了body里面。
    );
  }
}

// Scaffold HHScaffold() {
//   return Scaffold(
//     //Scaffold也是一个Widget 里面有appBar
//     backgroundColor: Colors.white,
//     appBar: AppBar(
//       //导航栏 不写就不显示导航栏
//       backgroundColor: WeChatThemeColor, //导航栏背景色
//       title: Text(title ?? 'Scaffold'), //导航栏标题
//       centerTitle: true, //安卓 切换应用时显示
//       elevation: 0.0, //去除导航栏底部的条
//     ),
//     body: body, //MyWidget父部件是body。开发界面是放到了body里面。
//   );
// }

class HHScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  const HHScaffold(this.body, {this.title, Key? key}) : super(key: key);
  // const ScaffoldDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold也是一个Widget 里面有appBar
      backgroundColor: Colors.white,
      appBar: AppBar(
        //导航栏 不写就不显示导航栏
        backgroundColor: themeColor, //导航栏背景色
        title: Text(title ?? 'Scaffold'), //导航栏标题
        centerTitle: true, //安卓 切换应用时显示
        elevation: 0.0, //去除导航栏底部的条
      ),
      body: body, //MyWidget父部件是body。开发界面是放到了body里面。
    );
  }
}
