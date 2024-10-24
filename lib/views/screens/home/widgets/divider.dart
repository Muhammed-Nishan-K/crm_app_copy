import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:flutter/material.dart';
Row divider({required String day,required BuildContext context}){
  return Row(
    children: [
      Expanded(
        child: Divider(
          indent: Screen.getWidth(context: context)*0.05,
          height: 2,
          color: Colors.black26 ,
          thickness: 1,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: Text(day),
      ),
      Expanded(
        child: Divider(
          endIndent: Screen.getWidth(context: context)*0.05,
          height: 2,
          color: Colors.black26,
          thickness: 1,
        ),
      ),
    ],
  );
}