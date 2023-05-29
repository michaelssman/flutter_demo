import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/discover/discover_child_page.dart';
import 'package:flutter_demo/tools/utils.dart';
import 'package:flutter_package/flutter_package.dart' as flutter_package;

import '../../tools/const.dart';
import 'firends_data.dart';

//定义内部类
class _FriendCell extends StatelessWidget {
  //文件私有

  const _FriendCell(
      {this.imageUrl, this.name, this.groupTitle, this.imageAssets}); //文件私有

  final String? imageUrl; //网络图片
  final String? name;
  final String? groupTitle; //组头
  final String? imageAssets; //本地图片

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //组头
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          height: groupTitle != null ? 30 : 0,
          color: themeColor,
          child: groupTitle != null
              ? Text(
                  groupTitle!,
                  style: const TextStyle(color: Colors.grey),
                )
              : null,
        ),
        Container(
          //cell的内容
          color: Colors.white,
          child: Row(
            children: [
              //图片
              Container(
                margin: const EdgeInsets.all(10),
                width: 34,
                height: 34,
                //圆角
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: DecorationImage(
                    image: imageUrl != null
                        ? NetworkImage(imageUrl!) as ImageProvider
                        : AssetImage(imageAssets!),
                  ),
                ),
              ),
              //昵称和下划线
              Container(
                // color: Colors.red,
                width: screenWidth(context) - 54,
                child: Column(
                  children: [
                    Container(
                      //上下居中，左对齐
                      alignment: Alignment.centerLeft,
                      height: 54,
                      child: Text(
                        name!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    //下划线
                    Container(
                      height: 0.5,
                      color: themeColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with AutomaticKeepAliveClientMixin<FriendsPage> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final double _cellHeight = 54.5;
  final double _groupHeight = 30.0; //组头高度
  //字典。里面放item和高度对应的数据（滚动需要使用）
  final Map _groupOffsetMap = {
    flutter_package.INDEX_WORDS[0]: 0.0, //放大镜
    flutter_package.INDEX_WORDS[1]: 0.0, //五角星
  };

  final List<Friends> _headerData = [
    Friends(imageAssets: 'images/新的朋友.png', name: '新的朋友'),
    Friends(imageAssets: 'images/群聊.png', name: '群聊'),
    Friends(imageAssets: 'images/标签.png', name: '标签'),
    Friends(imageAssets: 'images/公众号.png', name: '公众号'),
  ];
  final List<Friends> _listDatas = [];
  late ScrollController _scrollController;
  @override
  void initState() {
    //生命周期函数 页面渲染的时候
    // TODO: implement initState
    super.initState();
    print('通讯录的inti');
    //listView滚动需要使用
    _scrollController = ScrollController();
    //创建数据
    // _listDatas.addAll(datas);
    // _listDatas.addAll(datas);
    //等于下面一句
    _listDatas
      ..addAll(datas)
      ..addAll(datas);
    //模型数据排序
    _listDatas.sort((Friends a, Friends b) {
      return a.indexLetter!.compareTo(b.indexLetter!);
    });
    var _groupOffset = _cellHeight * _headerData.length;
    //经过循环计算，将每一个头的位置算出来，放入字典
    for (int i = 0; i < _listDatas.length; i++) {
      if (i < 1) {
        //第一个cell一定有头
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        //保存完了再加_groupOffset
        _groupOffset += _cellHeight + _groupHeight;
      } else if (_listDatas[i].indexLetter == _listDatas[i - 1].indexLetter) {
        //同一组的，不用存 只需要加cell的高度
        _groupOffset += _cellHeight;
      } else {
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        //保存完了再加_groupOffset
        _groupOffset += _cellHeight + _groupHeight;
      }
    }
  }

  //返回cell
  Widget _itemForRow(BuildContext context, int index) {
    //显示头部4个cell
    if (index < _headerData.length) {
      return _FriendCell(
        imageAssets: _headerData[index].imageAssets,
        name: _headerData[index].name,
      );
    }
    //剩下的cell
    //是否显示组头 当前的和前一个的indexLetter是否相等
    //不显示租名字
    bool _hiddenIndexLetter = (index - 4 > 0 &&
        _listDatas[index - 4].indexLetter == _listDatas[index - 5].indexLetter);
    return _FriendCell(
      imageUrl: _listDatas[index - 4].imageUrl,
      name: _listDatas[index - 4].name,
      groupTitle: _hiddenIndexLetter ? null : _listDatas[index - 4].indexLetter,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          //导航栏按钮
          actions: [
            GestureDetector(
              onTap: () {
                navigatorPush(
                    context,
                    const DiscoverChildPage(
                      title: '添加朋友',
                    ));
              },
              child: Container(
                // height: 45,
                // width: 45,
                margin: const EdgeInsets.only(right: 10),
                child: const Image(
                  image: AssetImage('images/icon_friends_add.png'),
                  width: 25,
                ),
              ),
            )
          ],
          backgroundColor: themeColor,
          title: const Text('通讯录'),
        ),
        body: Stack(
          children: [
            Container(
              //列表
              color: themeColor,
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: _itemForRow,
                itemCount: _listDatas.length + _headerData.length,
              ),
            ),
            //悬浮控件 索引条
            flutter_package.IndexBar(
              indexBarCallBack: (String str) {
                print('选中了$str');
                if (_groupOffsetMap[str] != null) {
                  _scrollController.animateTo(_groupOffsetMap[str],
                      duration: const Duration(microseconds: 100),
                      curve: Curves.easeIn);
                }
              },
            ),
          ],
        ));
  }
}
