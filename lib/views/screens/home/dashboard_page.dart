import 'dart:async';
import 'dart:ui'; // Required for ImageFilter.blur
import 'package:crm_android/bloc/navigation/navigation.bloc.dart';
import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:crm_android/models/nav_item_model.dart';
import 'package:crm_android/models/rive_model.dart';
import 'package:crm_android/services/leads.services.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:crm_android/utils/images.dart';
import 'package:crm_android/views/screens/home/pages/leads/leads_page.dart';
import 'package:crm_android/views/screens/home/widgets/animated_bar.dart';
import 'package:crm_android/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart' as rive;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<rive.SMIBool?> riveIconInputs = List.filled(bottomNavItems.length, null);
  final List<Widget> pages = [
    const LeadsPage(),
    const Center(child: Text('3D Stack Page')),
    const Center(child: Text('Profile Page')),
  ];
  final List<rive.StateMachineController?> controllers = [];

  void animateTheIcon(int index, NavigationBloc navigationBloc) {
    if (riveIconInputs[index] != null) {
      riveIconInputs[index]?.change(true);
      Future.delayed(const Duration(seconds: 1), () {
        riveIconInputs[index]?.change(false);
      });
    }
    navigationBloc.add(NavigateToPage(currentIndex: index));
  }

  void riveOnInit({required rive.Artboard artboard, required RiveModel riveIcon, required int index}) {
    final controller = rive.StateMachineController.fromArtboard(artboard, riveIcon.stateMachineName);
    if (controller != null) {
      artboard.addController(controller);
      controllers.add(controller);
      riveIconInputs[index] = controller.findInput<bool>("active") as rive.SMIBool;
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationBloc = context.read<NavigationBloc>();
    final leadsServices = LeadsServices();

    return SafeArea(
      child: Scaffold(
        backgroundColor: CRMAppColorPallete.scaffoldBackgroundColor,
        appBar: buildAppBar(context, leadsServices),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationChanged) {
              currentIndex = state.currentIndex;
            }
            return _buildBody(context, navigationBloc);
          },
        ),
      ),
    );
  }

  

  Widget _buildBody(BuildContext context, NavigationBloc navigationBloc) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Expanded(
                child: pages[currentIndex],
              ),
            ],
          ),
        ),
        _buildBottomNavigationBar(context, navigationBloc),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, NavigationBloc navigationBloc) {
    return Positioned(
      bottom: 20,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(bottomNavItems.length, (index) {
                  final riveIcon = bottomNavItems[index].rive;
                  return GestureDetector(
                    onTap: () {
                      animateTheIcon(index, navigationBloc);
                    },
                    child: Column(
                      children: [
                        AnimatedBar(
                          isActive: currentIndex == index,
                        ),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity: currentIndex == index ? 1 : 0.5,
                            child: rive.RiveAnimation.asset(
                              riveIcon.src,
                              artboard: riveIcon.artboard,
                              onInit: (artboard) {
                                riveOnInit(
                                  artboard: artboard,
                                  riveIcon: riveIcon,
                                  index: index,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
