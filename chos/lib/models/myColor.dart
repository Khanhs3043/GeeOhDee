import 'dart:ui';

import 'package:flutter/material.dart';

class MyColor{
  var lightText;
  var text;
  var background;
  var background2;
  MyColor({
    this.text = Colors.black,
    this.lightText = Colors.grey,
    this.background2 = const Color(0xffffffff),
    this.background = const Color(0xffebebec)
});
  switchTheme(bool isDark){
    if(isDark){
    text = Colors.black;
    lightText = Colors.grey;
    background2 = const Color(0xffffffff);
    background = const Color(0xffebebec);
    }else{
      text = Colors.white;
      lightText = Colors.grey;
      background2 = const Color(0xff1d1d1d);
      background = Colors.black;
    }
  }
}