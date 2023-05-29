import 'package:flutter/material.dart';
import 'package:flutter_demo/BaseWidget/base_widget.dart';
import 'package:flutter_demo/ChannelDemo/image_picker_demo.dart';
import 'package:flutter_demo/ChannelDemo/method_channel_demo.dart';
import 'package:flutter_demo/KeyDemo/global_key_demo.dart';
import 'package:flutter_demo/KeyDemo/key_demo.dart';
import 'package:flutter_demo/account/account.dart';
import 'package:flutter_demo/base_widget.dart';
import 'package:flutter_demo/json_map/json_map.dart';
import 'package:flutter_demo/lifecycle/inherited_demo.dart';
import 'package:flutter_demo/local_storage/index.dart';
import 'package:flutter_demo/provider/provider_demo.dart';
import 'package:flutter_demo/state_mag_demo.dart';
import 'package:flutter_demo/tools/const.dart';
import 'package:flutter_demo/tools/utils.dart';
import 'package:flutter_demo/widgets/list_view_demo.dart';
import 'package:flutter_demo/widgets/material_demo.dart';
import 'package:flutter_demo/widgets/scaffold_demo.dart';
import 'package:flutter_demo/widgets/text_demo.dart';

import '../../base_widget.dart';
import 'discover_cell.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('发现页面'),
        centerTitle: true, //安卓 切换应用时显示
        //去除导航栏底部的条
        elevation: 0.0,
      ),
      body: Container(
        //用Container包一下更灵活
        height: 800,
        color: themeColor,
        child: ListView(
          children: [
            listViewSection('widgets'),
            DiscoverCell(
              title: 'ListView',
              imageName: defaultImageName,
              onTapCallBack: () {
                navigatorPush(context, const ListViewDemo());
              },
            ),
            lineWidget(),
            DiscoverCell(
              title: 'ScaffoldDemo',
              imageName: defaultImageName,
              onTapCallBack: () {
                navigatorPush(context, const ScaffoldDemo());
              },
            ),
            lineWidget(),
            DiscoverCell(
              imageName: defaultImageName,
              title: 'StatefulWidget',
              onTapCallBack: () {
                navigatorPush(context, const StateManagerDemo());
              },
            ),
            lineWidget(),
            DiscoverCell(
              imageName: defaultImageName,
              title: 'MaterialAppDemo',
              onTapCallBack: () {
                navigatorPush(
                    context,
                    const MaterialAppDemo(HHScaffold(
                      BaseWidgetDemo(),
                      title: 'TextDemo',
                    )));
              },
            ),
            lineWidget(),
            DiscoverCell(
              imageName: defaultImageName,
              title: 'Text',
              onTapCallBack: () {
                navigatorPush(context, TextDemo());
              },
            ),
            listViewSection('key原理'),
            DiscoverCell(
              imageName: defaultImageName,
              title: 'Key的原理',
              onTapCallBack: () {
                navigatorPush(context, const KeyDemo());
              },
            ),
            lineWidget(),
            DiscoverCell(
              imageName: defaultImageName,
              title: 'GlobalKey',
              subTitle: '618限时特价',
              subImageName: 'images/badge.png',
              onTapCallBack: () {
                navigatorPush(context, GlobalKeyDemo());
              },
            ),
            listViewSection('Package'),
            DiscoverCell(
              title: 'image_picker',
              imageName: defaultImageName,
              onTapCallBack: () {
                navigatorPush(context, const ImagePickerDemo());
              },
            ),
            lineWidget(),
            DiscoverCell(
              title: 'Channel',
              imageName: defaultImageName,
              onTapCallBack: () {
                navigatorPush(context, const MethodChannelDemo());
              },
            ),
            listViewSection('数据共享'),
            DiscoverCell(
              title: '数据共享InheritedDemo',
              imageName: defaultImageName,
              onTapCallBack: () {
                navigatorPush(context, const InheritedDemo());
              },
            ),
            lineWidget(),
            DiscoverCell(
              title: 'Provider',
              imageName: defaultImageName,
              onTapCallBack: () {
                navigatorPush(context, const ProviderDemo());
              },
            ),
            listViewSection('数据持久化'),
            DiscoverCell(
              imageName: defaultImageName,
              title: '本地存储（配置）',
              onTapCallBack: () {
                navigatorPush(context, const LocalStorage());
              },
            ),
            listViewSection('json转模型 map'),
            DiscoverCell(
              imageName: defaultImageName,
              title: 'json转模型 map',
              onTapCallBack: () {
                json_map();
              },
            ),
            sizeBoxWidget(),
            DiscoverCell(
              imageName: defaultImageName,
              title: '记账Demo',
              onTapCallBack: () {
                navigatorPush(context, const Account());
              },
            ),
            sizeBoxWidget(),
          ],
        ),
      ),
    );
  }
}
