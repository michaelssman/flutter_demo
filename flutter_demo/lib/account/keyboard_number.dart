import 'package:flutter/material.dart';
import 'package:flutter_demo/tools/const.dart';

///数字输入键盘,保留两位小数
///
///[controller] 编辑器控制器
class NumberKeyboardActionSheet extends StatefulWidget {
  final String? name;
  final TextEditingController? controller;

  const NumberKeyboardActionSheet({Key? key, this.name, this.controller})
      : super(key: key);
  @override
  State createState() => _NumberKeyboardActionSheetState();
}

class _NumberKeyboardActionSheetState extends State<NumberKeyboardActionSheet> {
  ///键盘上的键值名称
  static const List<String> _keyNames = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '.',
    '0',
    '<-'
  ];

  ///控件点击事件
  void _onViewClick(String keyName) {
    var currentText = widget.controller?.text; //当前的文本
    if (RegExp('^\\d+\\.\\d{2}\$').hasMatch(currentText!) && keyName != '<-') {
      // Toast.showToastMessage('只能输入两位小数');
      print("只能输入两位小数");
      return;
    }
    if ((currentText == '' && (keyName == '.' || keyName == '<-')) ||
        (RegExp('\\.').hasMatch(currentText) && keyName == '.')) {
      return; //{不能第一个就输入.或者<-},{不能在已经输入了.再输入}
    }
    if (keyName == '<-') {
      //删除
      if (currentText.isEmpty) return;
      widget.controller?.text =
          currentText.substring(0, currentText.length - 1);
      return;
    }
    if (currentText == '0' && (RegExp('^[0-9]\$').hasMatch(keyName))) {
      //{如果第一位是数字0，那么第二次输入的是1-9，那么就替换}
      widget.controller?.text = keyName;
      print("哈哈");
      return;
    }
    widget.controller?.text = currentText + keyName;
  }

  ///构建显示数字键盘的视图
  Widget _showKeyboardGridView() {
    List<Widget> keyWidgets = [];
    for (int i = 0; i < _keyNames.length; i++) {
      keyWidgets.add(
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () => _onViewClick(_keyNames[i]),
            child: SizedBox(
              width: screenWidth(context) / 3.0,
              height: 50,
              child: Center(
                child: i == _keyNames.length - 1
                    ? const Icon(Icons.backspace)
                    : Text(
                        _keyNames[i],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(
                            0xff606060,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      );
    }
    return Wrap(children: keyWidgets);
  }

  ///完整输入的Float值
  void _completeInputFloatValue() {
    var currentText = widget.controller!.text;
    if (currentText.endsWith('.')) {
      widget.controller!.text += '00';
    } else if (RegExp('^\\d+\\.\\d\$').hasMatch(currentText)) {
      widget.controller!.text += '0';
    } else if (RegExp('^\\d+\$').hasMatch(currentText)) {
      widget.controller!.text += '.00';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: <Widget>[
          const Divider(
            height: 1.0,
          ),
          _showKeyboardGridView(),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    _completeInputFloatValue();
    super.deactivate();
  }
}
