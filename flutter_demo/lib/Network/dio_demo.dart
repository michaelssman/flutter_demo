import 'dart:io'; //保存文件路径

import 'package:dio/dio.dart';

///简单的网络请求
void dioDemo() {
  //发送网络请求
  final dio = Dio();
  dio.get('https://www.baidu.com').then((value) => print(value));
}

void downloadDemo() {
  //发送网络请求
  //1.创建dio对象
  final dio = Dio();
  //2.下载数据
  var downloadUrl =
      'https://edu-files-1251502357.cos.ap-shanghai.myqcloud.com/CourseTeacher_2.8.2.24_DailyBuild.dmg';
  String savePath = '/Users/michael/Desktop/123/腾讯课堂.dmg';
  // download1(dio, downloadUrl, savePath);
  download2(dio, downloadUrl, savePath);
}

///存到手机本地
void download2(Dio dio, String url, String savePath) {
  //手机端
  String iOSPath = Directory.systemTemp.path + '腾讯课堂.dmg';
  print(iOSPath);
  dio
      .download(url, (Headers headers) {
        // // Extra info: redirect counts
        // print(headers.value('redirects'));
        // // Extra info: real uri
        // print(headers.value('uri'));
        return iOSPath;
      }, onReceiveProgress: showDownloadProgress)
      .whenComplete(() => print('下载完成'))
      .catchError((e) => print(e));
}

///保存到电脑
void download1(Dio dio, String url, String savePath) {
  dio
      .download(url, savePath, onReceiveProgress: showDownloadProgress)
      .then((value) => print(value))
      .whenComplete(() => print('结束了'))
      .catchError((e) => print(e));
}

///下载进度
void showDownloadProgress(int count, int total) {
  // print('count:$count  total:$total');
  if (total != -1) {
    print((count / total * 100).toStringAsFixed(0) + '%');
  }
}
