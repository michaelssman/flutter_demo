import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/material_demo.dart';

import 'root_page.dart';

void main() => runApp(const APP());

//MaterialApp
class APP extends StatelessWidget {
  const APP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialAppDemo(RootPage());
  }
}
