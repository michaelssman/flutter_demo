import 'dart:convert';

import 'package:http/http.dart' as http;

class Chat {
  final String? name;
  final String? message;
  final String? imageUrl;
  Chat({this.name, this.message, this.imageUrl});
  //工厂构造 可以有返回值
  factory Chat.formMap(Map map) {
    return Chat(
      name: map['name'],
      message: map['message'],
      imageUrl: map['imageUrl'],
    );
  }
}

//异步获取数据
Future<List<Chat>> getDatas() async {
  final url =
      Uri.parse('http://rap2api.taobao.org/app/mock/295570/api/chat/list');
  //发送请求
  final response = await http.get(url); //异步获取数据 会等，但是不会卡住UI。
  // print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    //获取响应数据，json数据转成Map类型 类似字典
    final responsBody = json.decode(response.body);
    List<Chat> chatList = responsBody['chat_list']
        .map<Chat>((item) => Chat.formMap(item))
        .toList(); //map()：List的遍历方法
    // print(chatList);
    return chatList;
  } else {
    throw Exception('statusCode:${response.statusCode}');
  }
}
