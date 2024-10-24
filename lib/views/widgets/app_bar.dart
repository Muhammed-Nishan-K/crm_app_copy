import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:crm_android/services/leads.services.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:crm_android/utils/images.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, LeadsServices leadsServices) {
    return AppBar(
      title: GestureDetector(
        onTap: () async {
          await leadsServices.getLeads();
        },
        child: SizedBox(
          width: Screen.getWidth(context: context) * 0.3,
          height: 100,
          child: Image.asset(CRMImages.logo),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Screen.getWidth(context: context) * 0.07),
          child: ElevatedButton.icon(
            onPressed: () {
              // Add your logout logic here
            },
            icon: Image.asset(CRMImages.logOut),
            label: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: Screen.getWidth(context: context) * 0.03,
              ),
            ),
            style: ElevatedButton.styleFrom(
              overlayColor: CRMAppColorPallete.lightBlue,
              fixedSize: Size(Screen.getWidth(context: context) * 0.23, 15),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              elevation: 0,
              side: const BorderSide(color: CRMAppColorPallete.lightBlue),
              backgroundColor: CRMAppColorPallete.lightBlue.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
    );
  }