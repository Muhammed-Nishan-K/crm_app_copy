import 'package:flutter/material.dart';

class Screen {

  static double getWidth({required BuildContext context}){
    return MediaQuery.sizeOf(context).width;
  }
  static double getHeight({required BuildContext context}){
    return MediaQuery.sizeOf(context).height;
  }
}
