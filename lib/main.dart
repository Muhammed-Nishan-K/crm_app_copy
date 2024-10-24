import 'package:crm_android/dependency_injection.dart';
import 'package:crm_android/splash_screen.dart';
import 'package:crm_android/views/screens/auth/login_page.dart';
import 'package:crm_android/views/screens/home/dashboard_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CRMApp());
}

class CRMApp extends StatelessWidget {
  const CRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
