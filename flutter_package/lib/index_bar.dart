part of 'flutter_package.dart';

///抽取索引条

class IndexBar extends StatefulWidget {
  //回调 接口 外部使用
  final void Function(String str)? indexBarCallBack;
  final ImageProvider? image;
  const IndexBar({Key? key, this.indexBarCallBack, this.image})
      : super(key: key);

  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  Color _bkColor = const Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.black;
  double _indicatorY = 0.0;
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //获取选中的Item的下标
  int getIndex(BuildContext context, Offset globalPosition) {
    //拿到当前小部件的盒子
    RenderBox box = context.findRenderObject() as RenderBox;
    //拿全局位置换算成相对于自己的位置
    print(box.globalToLocal(globalPosition));
    double y = box.globalToLocal(globalPosition).dy;
    //拿到y值，globalToLocal当前位置和我部件原点（小部件左上角）的距离（x,y）
    //算出字符高度
    var itemHeight = screenHeight(context) / 2 / INDEX_WORDS.length;
    //算出第几个item
    int index = y ~/ itemHeight; //取整
    index = index.clamp(0, INDEX_WORDS.length - 1); //范围
    print('现在选中了第$index个item ${INDEX_WORDS[index]}');
    // print('现在在哪里${details.globalPosition}'); //相对于整个屏幕的全局坐标
    return index;
  }

  @override
  Widget build(BuildContext context) {
    //右边的索引
    final List<Widget> words = [];
    final double _indexBarHeight = screenHeight(context) / 2; //索引条高度
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      words.add(Expanded(
          child: Text(
        INDEX_WORDS[i],
        style: TextStyle(fontSize: 10, color: _textColor),
      )));
    }
    return Positioned(
      right: 0.0,
      top: screenHeight(context) / 8,
      width: 120,
      height: _indexBarHeight,
      child: Row(
        children: [
          //指示器
          //需要3个变量：位置 字符 是否显示
          Container(
            alignment: Alignment(0, _indicatorY),
            width: 100,
            // color: Colors.red,
            child: _indicatorHidden
                ? null
                : Stack(
                    alignment: const Alignment(-0.2, 0),
                    children: [
                      Image(
                        image: widget.image ??
                            const AssetImage('lib/images/bubble.png',
                                package: 'flutter_package'),
                        width: 60,
                      ),
                      //上层是字符
                      Text(
                        _indicatorText,
                        style:
                            const TextStyle(fontSize: 35, color: Colors.white),
                      )
                    ],
                  ),
          ),
          //索引条
          GestureDetector(
            //拖拽
            //点击进来
            onVerticalDragDown: (DragDownDetails details) {
              print('进入到了${details.globalPosition}'); //相对于整个屏幕的全局坐标
              int index = getIndex(context, details.globalPosition);
              widget.indexBarCallBack!(INDEX_WORDS[index]);
              setState(() {
                _indicatorY = 2.2 / INDEX_WORDS.length * index - 1.1;
                _indicatorText = INDEX_WORDS[index];
                _indicatorHidden = false;
                _bkColor = const Color.fromRGBO(1, 1, 1, 0.5);
                _textColor = Colors.white;
              });
            },
            onVerticalDragUpdate: (DragUpdateDetails details) {
              print('进入到了${details.globalPosition}'); //相对于整个屏幕的全局坐标
              int index = getIndex(context, details.globalPosition);
              String str = INDEX_WORDS[index];
              widget.indexBarCallBack!(str);
              setState(() {
                _indicatorY = 2.2 / INDEX_WORDS.length * index - 1.1;
                _indicatorText = INDEX_WORDS[index];
                _indicatorHidden = false;
              });
            },
            onVerticalDragEnd: (DragEndDetails details) {
              setState(() {
                _indicatorHidden = true;
                _bkColor = const Color.fromRGBO(1, 1, 1, 0.0);
                _textColor = Colors.black;
              });
            },
            child: Container(
              width: 20,
              color: _bkColor,
              child: Column(
                children: words,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//主题色
const Color WeChatThemeColor = Color.fromRGBO(220, 220, 220, 1.0);

//屏幕宽高
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
