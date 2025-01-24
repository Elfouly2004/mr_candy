import 'package:flutter/material.dart';


class CystomTxt extends StatelessWidget {
   const CystomTxt({super.key, required this.data, required this.fontSize, required this.color});
final String data;
final double fontSize;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
     data ,
      textAlign:  TextAlign.start,

      textDirection: TextDirection.rtl,
      style: TextStyle(
          fontSize: fontSize ,
          color: color,
          fontWeight: FontWeight.bold

      ),
    );
  }
}
