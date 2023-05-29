import 'package:flutter/material.dart';
import 'package:flutter_demo/tools/const.dart';

import 'chat_page.dart';

class SearchPage extends StatefulWidget {
  //参数 接收参数
  final List<Chat>? datas;
  const SearchPage({Key? key, this.datas}) : super(key: key); //对外构造函数

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchStr = ''; //搜索的内容
  final List<Chat> _models = [];
  //搜索
  void _searchData(String text) {
    _models.clear(); //每次搜索先清空
    _searchStr = text;
    if (text.length > 0) {
      for (int i = 0; i < widget.datas!.length; i++) {
        //循环检索
        String? name = widget.datas![i].name;
        if (name!.contains(text)) {
          _models.add(widget.datas![i]);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(
            onChanged: (String text) {
              print('我接收到了$text');
              _searchData(text);
            },
          ),
          Expanded(
              flex: 1, //权重 占比
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  // shrinkWrap: true, //根据ListView的内容大小来展示
                  itemCount: _models.length,
                  itemBuilder: _buildCellForRow,
                ),
              )),
        ],
      ),
    );
  }

  //cell
  Widget _buildCellForRow(BuildContext context, int index) {
    return ListTile(
      //ListTile根据内容拉伸
      title: _title(_models[index].name!), //名字
      subtitle: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(right: 10),
        height: 25,
        child: Text(
          _models[index].message!,
          overflow: TextOverflow.ellipsis,
        ), //文字显示...
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            image: DecorationImage(
              image: NetworkImage(_models[index].imageUrl!),
            )),
      ),
    );
  }

  final TextStyle _normalStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  final TextStyle _highlightedStyle = const TextStyle(
    fontSize: 16,
    color: Colors.green,
  );
  //cell 名字
  Widget _title(String name) {
    List<TextSpan> spans = [];
    //截取字符串
    List<String> strs = name.split(_searchStr);
    for (int i = 0; i < strs.length; i++) {
      String str = strs[i]; //拿出字符串
      if (str == '' && i < strs.length - 1) {
        spans.add(TextSpan(text: _searchStr, style: _highlightedStyle));
      } else {
        spans.add(TextSpan(text: str, style: _normalStyle));
        if (i < strs.length - 1) {
          //不是末尾
          spans.add(TextSpan(text: _searchStr, style: _highlightedStyle));
        }
      }
    }
    return RichText(
      text: TextSpan(children: spans),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged; //回调 输入内容 搜索数据
  const SearchBar({this.onChanged});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;
  void _onChange(String text) {
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
    setState(() {
      _showClear = text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      color: themeColor,
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ), //上半部分留空
          Container(
            height: 44,
            // color: Colors.red,
            child: Row(
              children: [
                Container(
                  width: screenWidth(context) - 40,
                  height: 34,
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  // color: Colors.yellow,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Image(
                        image: AssetImage('images/放大镜b.png'),
                        width: 20,
                        color: Colors.grey,
                      ), //放大镜
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _controller,
                          onChanged: _onChange,
                          //自动聚焦
                          autofocus: true,
                          //光标颜色
                          cursorColor: Colors.green,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: const InputDecoration(
                              //内容约束
                              contentPadding:
                                  EdgeInsets.only(left: 5, bottom: 10),
                              border: InputBorder.none, //输入框边框
                              hintText: '搜索'),
                        ),
                      ), //TextField
                      _showClear
                          ? GestureDetector(
                              onTap: () {
                                _controller.clear();
                                setState(() {
                                  _onChange(''); //设置空
                                });
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: Colors.grey,
                                size: 20,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ), //左边圆角背景
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); //pop返回
                  },
                  child: const Text('取消'), //取消按钮,
                ),
              ],
            ),
          ), //下面的搜索条
        ],
      ),
    );
  }
}
