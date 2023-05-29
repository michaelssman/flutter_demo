import 'package:flutter/material.dart';
import 'package:flutter_demo/tools/const.dart';

import 'chat_page.dart';
import 'search_page.dart';

class SearchCell extends StatelessWidget {
  //接收参数
  final List<Chat>? datas;
  //对外构造方法
  const SearchCell({this.datas, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('点击了搜索框!');
        //push页面
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SearchPage(
                  datas: datas,
                )));
      },
      child: Container(
        height: 44,
        color: themeColor,
        padding: const EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.center, //居中
          children: [
            Container(
              decoration: BoxDecoration(
                //圆角
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
            ), //白底
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage('images/放大镜b.png'),
                  width: 15,
                  color: Colors.grey,
                ),
                Text(
                  ' 搜索',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
