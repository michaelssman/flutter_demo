import 'package:flutter/material.dart';
import 'package:flutter_demo/account/acc_manager.dart';
import 'package:flutter_demo/account/acc_tabbar.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.yellow,
        primarySwatch: Colors.grey, //主题色 影响整个app
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  //定义一个pages数组
  final List<Widget> _pages = [
    const AccManager(),
    const AccTabBar(),
    const AccManager()
  ];
  final PageController _pageController = PageController(); //保存在widget树中 不被销毁
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        //禁止拖拽
        // physics: const NeverScrollableScrollPhysics(),
        //滑动改变
        onPageChanged: (int index) {
          _currentIndex = index;
          setState(() {});
        },
        controller: _pageController,
        children: _pages,
      ),
      // 底部导航条
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 16.0, //文字选中
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(_currentIndex);
          });
        },
        //样式 不然4个显示是白色的，看不到
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.green, //选中时的颜色
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: '明细'),
          BottomNavigationBarItem(
            icon: Image(
              height: 20,
              width: 20,
              image: AssetImage('images/tabbar_chat.png'),
            ),
            activeIcon: Image(
              height: 20,
              width: 20,
              image: AssetImage('images/tabbar_chat_hl.png'),
            ),
            label: '记一笔',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: '账户'),
        ],
      ),
    );
  }
}
