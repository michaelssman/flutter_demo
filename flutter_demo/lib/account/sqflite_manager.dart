import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteManager {
  final String _tableName = "MC_TEXT";
  late Database db;
  //创建数据库文件
  Future<Database> initDatabase() async {
    var basePath = await getDatabasesPath();
    String dbPath = join(basePath, 'mic_db.db');
    print(dbPath);
    //打开数据库，创建数据库文件
    Database db = await openDatabase(
      dbPath, version: 1,
      //arg1:创建成功的数据库 arg2：版本
      onCreate: (Database db, int version) async {
        //创建表
        await db.execute(
            'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, ac_type TEXT, ac_name TEXT, ac_amount INT)');
      },
    );
    return db;
  }

  ///插入数据
  insertData() async {
    db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO $_tableName(ac_type,ac_name,ac_amount) VALUES("网络","支付宝",18)')
          .then((value) => print(value));
      txn
          .rawInsert(
              'INSERT INTO $_tableName(ac_type,ac_name,ac_amount) VALUES("网络","微信",18)')
          .then((value) => print(value));
      txn
          .rawInsert(
              'INSERT INTO $_tableName(ac_type,ac_name,ac_amount) VALUES("银行","民生",18)')
          .then((value) => print(value));
      txn
          .rawInsert(
              'INSERT INTO $_tableName(ac_type,ac_name,ac_amount) VALUES("银行","建行",18)')
          .then((value) => print(value));
      txn
          .rawInsert(
              'INSERT INTO $_tableName(ac_type,ac_name,ac_amount) VALUES("银行","农行",18)')
          .then((value) => print(value));
      txn
          .rawInsert(
              'INSERT INTO $_tableName(ac_type,ac_name,ac_amount) VALUES("现金","现金",28)')
          .then((value) => print(value));
    });
  }

  Future selectData() async {
    // Future.wait([
    //   /// 查找所有的分类
    //   Future(() {
    //     db.rawQuery('SELECT ac_type FROM $_tableName').then((value) {
    //       var types = <String>{};
    //       value.forEach((element) {
    //         types.add(element["ac_type"] as String);
    //       });
    //       print("所有分类：$types");
    //       return types;
    //     });
    //   }),
    //   /// 查找所有的账户
    //   Future(() {
    //   }),
    // ]).then((value) {});

    var result = {};
    await db.rawQuery('SELECT * FROM $_tableName').then((items) {
      for (var element in items) {
        var key = element["ac_type"];
        var lists = [];
        if (result.keys.contains(key)) {
          lists = result[key];
        }
        lists.add(element);
        result[key] = lists;
      }
      print("所有数据：$result");
    });
    return result;
  }
}
