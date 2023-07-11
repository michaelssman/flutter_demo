import 'package:flutter/material.dart';
import 'package:flutter_demo/chart/view/chart_bar.dart';

import 'chart_bean.dart';

class ChartBarPainter extends StatelessWidget {
  const ChartBarPainter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.white,
      child: ChartBar(
        chartBeans: [
          ChartBean(x: '12-01', y: 30, color: Colors.red),
          ChartBean(x: '12-02', y: 100, color: Colors.yellow),
          ChartBean(x: '12-03', y: 70, color: Colors.green),
          ChartBean(x: '12-04', y: 70, color: Colors.blue),
          ChartBean(x: '12-05', y: 30, color: Colors.deepPurple),
          ChartBean(x: '12-06', y: 90, color: Colors.deepOrange),
          ChartBean(x: '12-01', y: 30, color: Colors.red),
          ChartBean(x: '12-02', y: 100, color: Colors.yellow),
          ChartBean(x: '12-03', y: 70, color: Colors.green),
          ChartBean(x: '12-04', y: 70, color: Colors.blue),
          ChartBean(x: '12-05', y: 30, color: Colors.deepPurple),
          ChartBean(x: '12-06', y: 90, color: Colors.deepOrange),
          ChartBean(x: '12-07', y: 50, color: Colors.greenAccent)
        ],
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 5 * 1.8),
        rectColor: Colors.deepPurple,
        isShowX: true,
        fontColor: Colors.white,
        rectShadowColor: Colors.white.withOpacity(0.5),
        isReverse: false,
        isCanTouch: true,
        isShowTouchShadow: true,
        isShowTouchValue: true,
        rectRadiusTopLeft: 50,
        rectRadiusTopRight: 50,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }
}
