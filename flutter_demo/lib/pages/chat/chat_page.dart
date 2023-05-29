import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/tools/const.dart';
import 'package:flutter_demo/tools/http_manager.dart';

import 'search_cell.dart';

class Chat {
  final String? name;
  final String? message;
  final String? imageUrl;
  Chat({this.name, this.message, this.imageUrl});
  //工厂构造 可以有返回值
  factory Chat.formMap(Map map) {
    return Chat(
      name: map['name'],
      message: map['message'],
      imageUrl: map['imageUrl'],
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin<ChatPage> {
  //实现get方法
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  bool _cancelConnect = false;
  //模型数组 保存网络请求回来的数据
  List<Chat> _datas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //获取网络数据
    final a = getDatas();
    a
        .then((List<Chat> datas) {
          if (!_cancelConnect) {
            setState(() {
              _datas = datas;
            });
          }
        })
        .catchError((error) {
          _cancelConnect = true;
          print(error); //打印异常
        })
        .whenComplete(() {
          print('完毕！');
        })
        .timeout(const Duration(milliseconds: 1000000))
        .catchError((timeout) {
          print('超时了 $timeout');
          _cancelConnect = true;
          //不需要渲染UI 就不需要调setState();
        });
  }

  //异步获取数据
  Future<List<Chat>> getDatas() async {
    _cancelConnect = false;
    //发送请求
    final response = await HttpManager.get(
        'http://rap2api.taobao.org/app/mock/295570/api/chat/list'); //异步获取数据 会等，但是不会卡住UI。
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      List<Chat> chatList = response.data['chat_list']
          .map<Chat>((item) => Chat.formMap(item))
          .toList(); //map()：List的遍历方法
      // print(chatList);
      return chatList;
    } else {
      throw Exception('statusCode:${response.statusCode}');
    }
  }

  Widget _itemBuilderForRow(BuildContext context, int index) {
    if (index == 0) {
      return SearchCell(
        datas: _datas,
      );
    }
    index--; //需要减一  因为搜索框占一个
    return ListTile(
      //ListTile根据内容拉伸
      title: Text(_datas[index].name!),
      subtitle: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(right: 10),
        height: 25,
        child: Text(
          _datas[index].message!,
          overflow: TextOverflow.ellipsis,
        ), //文字显示...
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            image: DecorationImage(
              image: NetworkImage(_datas[index].imageUrl!),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0, //去除导航栏下面的线
        backgroundColor: themeColor,
        title: const Text('微信页面'),
        centerTitle: true, //居中
      ),
      body: Container(
        // child: FutureBuilder(
        //   future: getDatas(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     print('data:${snapshot.data}');
        //     print('data:${snapshot.connectionState}'); //waiting、done
        //     //正在加载
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: Text('loading'),
        //       );
        //     }
        //     //加载完毕
        //     return ListView(
        //       children: snapshot.data.map<Widget>((Chat item) {
        //         //遍历
        //         return ListTile(
        //           //ListTile根据内容拉伸
        //           title: Text(item.name!),
        //           subtitle: Container(
        //             alignment: Alignment.bottomCenter,
        //             padding: EdgeInsets.only(right: 10),
        //             height: 25,
        //             child: Text(
        //               item.message!,
        //               overflow: TextOverflow.ellipsis,
        //             ), //文字显示...
        //           ),
        //           leading: Container(
        //             width: 44,
        //             height: 44,
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(6.0),
        //                 image: DecorationImage(
        //                   image: NetworkImage(item.imageUrl!),
        //                 )),
        //           ),
        //         );
        //       }).toList(), //需要toList 因为children属性是数组
        //     );
        //   },
        // ),
        child: Container(
          child: _datas.length == 0
              ? const Center(
                  child: Text('loading...'),
                )
              : ListView.builder(
                  itemCount: _datas.length + 1, //加一个搜索框
                  itemBuilder: _itemBuilderForRow,
                ),
        ),
      ),
    );
  }
}
