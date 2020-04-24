
import 'package:flutter/material.dart';

class CommonStyles{

  static TextStyle SectionTextStyle(){
    return TextStyle(
        fontSize: 25.0,
        color: Colors.black,
        fontWeight: FontWeight.w600);
  }

  static TextStyle TileTextStyle({double size}){
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: size != null ? size:14.0,
    );
  }
}