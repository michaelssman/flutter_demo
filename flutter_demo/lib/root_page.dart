import 'package:flutter/material.dart';

import 'pages/chat/chat_page.dart';
import 'pages/discover/discover_page.dart';
import 'pages/friends/friends_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  //定义一个pages数组
  final List<Widget> _pages = [
    const ChatPage(),
    const FriendsPage(),
    const DiscoverPage(),
  ];
  final PageController _pageController = PageController(); //保存在widget树中 不被销毁
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _pages[_currentIndex],
      body: PageView(
        //禁止拖拽
        // physics: NeverScrollableScrollPhysics(),
        //滑动改变
        onPageChanged: (int index) {
          _currentIndex = index;
          setState(() {});
        },
        controller: _pageController,
        children: _pages,
      ),
      //底部导航条
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
              label: '微信'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: '通讯录'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Demos'),
        ],
      ),
    );
  }
}
