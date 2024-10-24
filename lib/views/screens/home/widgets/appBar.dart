import 'package:crm_android/utils/colors.dart';
import 'package:flutter/material.dart';

AppBar appBar() {
    return AppBar(
      backgroundColor: CRMAppColorPallete.scaffoldBackgroundColor,
      title: const Text("My Work"),
      
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ElevatedButton.icon(
            onPressed: () {},
            label: const Text(
              'Get more',
              style: TextStyle(color: CRMAppColorPallete.textColor),
            ),
            icon: const Icon(
              Icons.read_more_rounded,
              color: Colors.black,
            ),
            style: const ButtonStyle(
                side: WidgetStatePropertyAll(BorderSide(color: CRMAppColorPallete.buttonBorder)),
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                elevation: WidgetStatePropertyAll(0.0)),
          ),
        )
      ],
    );
  }