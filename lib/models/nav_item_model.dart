import 'package:crm_android/models/rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: "Home",
    rive: RiveModel(
      src: "assets/icons/bottom_nav_icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_Interactivity",
    ),
  ),
  NavItemModel(
    title: "Chat",
    rive: RiveModel(
      src: "assets/icons/icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
    ),
  ),
  NavItemModel(
    title: "Profile",
    rive: RiveModel(
      src: "assets/icons/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
    ),
  ),
];
