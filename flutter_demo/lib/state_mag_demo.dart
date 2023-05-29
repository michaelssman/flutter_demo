import 'package:flutter/material.dart';

//外部可能会传递数据
class StateManagerDemo extends StatefulWidget {
  const StateManagerDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SMDState();
  }
}

//状态管理者
class _SMDState extends State<StateManagerDemo> {
  int count = 10;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //开发基于MaterialApp
      home: Scaffold(
        //Scaffold也是一个Widget 里面有appBar
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('StateManagerDemo'),
        ),
        body: Center(
          child: Chip(
            label: Text('$count'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              //相当于从新调用一次build方法
              count++;
            });
            print("count = $count");
          },
        ),
      ),
    );
  }
}
