import 'package:flutter/material.dart';
import 'package:flutter_demo/tools/utils.dart';

import 'discover_child_page.dart';

class DiscoverCell extends StatefulWidget {
  final String title;
  final String imageName;
  final String? subTitle;
  final String? subImageName;
  //callback 点击
  //回调 接口 外部使用
  final void Function()? onTapCallBack;

  const DiscoverCell({
    Key? key,
    required this.title, //title必须有
    this.subTitle,
    required this.imageName, //imageName必须有
    this.subImageName,
    this.onTapCallBack, //callback 点击
  })  : assert(title != null, 'title不能为空！'),
        assert(imageName != null, 'imageName不能为空！'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  Color _currentColor = Colors.white;

  void pushChildPage(BuildContext context) {
    navigatorPush(
        context,
        DiscoverChildPage(
          title: widget.title,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hehe $widget.title');
        if (widget.onTapCallBack != null) {
          widget.onTapCallBack!();
        } else {
          pushChildPage(context);
        }
        setState(() {
          _currentColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _currentColor = Colors.grey;
        });
      },
      onTapCancel: () {
        setState(() {
          _currentColor = Colors.white;
        });
      },
      child: Container(
        height: 55,
        color: _currentColor,
        child: Row(
          //主轴时spaceBetween，往两边分散
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //left
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  //图标
                  Image(
                    image: AssetImage(widget.imageName),
                    width: 20,
                  ),
                  //间隙
                  const SizedBox(
                    width: 15,
                  ),
                  //title
                  Text(widget.title),
                ],
              ),
            ),
            //right
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  //subTitle
                  widget.subTitle != null ? Text(widget.subTitle!) : Text(''),
                  //subImage
                  widget.subImageName != null
                      ? Image.asset(
                          widget.subImageName!,
                          width: 15,
                        )
                      : Container(),
                  //箭头
                  const Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
