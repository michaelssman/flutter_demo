import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//使用`shared_preferences`会和原生通讯，存储键值对。iOS是和NSUserDefault。

class LocalStorage extends StatefulWidget {
  const LocalStorage({Key? key}) : super(key: key);

  @override
  State<LocalStorage> createState() => _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorage> {
  String prefsKey = 'counter';

  int _counter = 0;
  void _incrementCounter() async {
    //创建对象，用于操作存储数据的读取
    // SharedPreferences prefs = await SharedPreferences.getInstance().then((value) => print(value));
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      setState(() {
        _counter++;
        prefs.setInt(prefsKey, _counter);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //加载数据
    _loadCount();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('本地存储'),
      ),
      body: Center(
        // Center is a LayoutDemo widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _loadCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt(prefsKey) ?? 0;
    });
  }
}
