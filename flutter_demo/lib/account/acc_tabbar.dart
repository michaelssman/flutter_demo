import 'package:flutter/material.dart';
import 'package:flutter_demo/account/acc.dart';
import 'package:flutter_demo/tools/const.dart';

class AccTabBar extends StatefulWidget {
  const AccTabBar({Key? key}) : super(key: key);

  @override
  State<AccTabBar> createState() => _AccTabBarState();
}

class _AccTabBarState extends State<AccTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ["支出", "收入", "转账", "余额"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold也是一个Widget 里面有appBar
      backgroundColor: Colors.white,
      appBar: AppBar(
        //导航栏 不写就不显示导航栏
        backgroundColor: themeColor, //导航栏背景色
        title: const Text("记一笔"), //导航栏标题
        centerTitle: true, //安卓 切换应用时显示
        elevation: 0.0, //去除导航栏底部的条
        bottom: TabBar(
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
          controller: _tabController,
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return const Acc();
          }).toList()), //MyWidget父部件是body。开发界面是放到了body里面。
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //释放资源
    _tabController.dispose();
    super.dispose();
  }
}
