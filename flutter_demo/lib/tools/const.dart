import 'package:flutter/material.dart';

const defaultImageName = 'images/摇一摇.png';

//主题色
const Color themeColor = Color.fromRGBO(220, 220, 220, 1.0);

const mPrimaryColor = Colors.white;
const mTextDarkColor = Color(0xFF1D1D35);
const mTextLightColor = Colors.white;
const mDefaultPadding = 20.0;

//屏幕宽高
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
