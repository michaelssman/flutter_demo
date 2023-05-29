import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/scaffold_demo.dart';

/// 数据管理类
/// 里面有数据 有部件，数据改变时通知依赖数据的部件
class MyData extends InheritedWidget {
  /// 放到树的根 才能共享数据
  final int data; //需要在子组件中共享的数据

  /// 构造方法
  const MyData({required this.data, required Widget child})
      : super(child: child); //必传参数 required

  /// 定义一个便捷方法，方便子组件中的Widget去获取共享的数据
  static MyData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyData>();
  }

  //该回调决定当前data发生变化时，是否通知子组件依赖data的Widget（使用了MyData.of的组件）
  @override
  bool updateShouldNotify(MyData oldWidget) {
    // TODO: implement updateShouldNotify
    //如果返回true，子部件中依赖数据的Widget（build中有MyData.of函数）的didChangeDependencies会被调用
    return oldWidget.data != data;
  }
}

class InheritedDemo extends StatefulWidget {
  const InheritedDemo({Key? key}) : super(key: key);

  @override
  _InheritedDemoState createState() => _InheritedDemoState();
}

class _InheritedDemoState extends State<InheritedDemo> {
  //几个页面数据共享
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('hello hh'),);//Center无状态 需要加const 不然会有警告
    return HHScaffold(
      MyData(
          data: _count,
          child: Column(
            children: [
              Test1(_count),
              ElevatedButton(
                  onPressed: () {
                    _count++;
                    setState(() {});
                  },
                  child: const Text('我是按钮'))
            ],
          )), //MyWidget父部件是body。开发界面是放到了body里面。
      title: '数据共享',
    );
  }
}

class Test1 extends StatelessWidget {
  final int count;
  const Test1(this.count);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Test2(count);
  }
}

class Test2 extends StatelessWidget {
  final int count;
  const Test2(this.count);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Test3(count);
  }
}

class Test3 extends StatefulWidget {
  final int count;
  const Test3(this.count);
  @override
  _Test3State createState() => _Test3State();
}

class _Test3State extends State<Test3> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('我来了');
    return Text(MyData.of(context)!.data.toString()); //!解包
  }
}
