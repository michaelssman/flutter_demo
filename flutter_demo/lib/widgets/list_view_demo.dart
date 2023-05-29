import 'package:flutter/material.dart';
import 'package:flutter_demo/BaseWidget/base_widget.dart';
import 'package:flutter_demo/widgets/scaffold_demo.dart';

import '../model/car.dart';

class ListViewDemo extends StatelessWidget {
  const ListViewDemo({Key? key}) : super(key: key);

  //dart中不希望外界访问的话加下划线 下划线的内部指文件内部。整个文件都可以访问，其它文件不能访问。
  Widget _itemForRow(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(10), //上下左右都有
      // //只有一个部件
      // child: Image.network(datas[index].imageUrl!),//Image的匿名构造函数network 加载网络图片
      //两个部件
      /*
      小部件和小部件排列只有三种方式：
      1 横着
      2 竖着
      3 叠着
       */
      child: Column(
        children: <Widget>[
          Image.network(datas[index].imageUrl!),
          sizeBoxWidget(),
          Text(
            datas[index].name!,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18.0,
              fontStyle: FontStyle.italic, //斜体
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HHScaffold(
      ListView.builder(
        itemBuilder: _itemForRow, //itemBuilder是一个回调，方法返回一个widget 相当于cell
        itemCount: datas.length,
      ),
      title: 'ListViewDemo',
    );
  }
}
