import 'dart:ui';

import 'package:crm_android/bloc/navigation/navigation.bloc.dart';
import 'package:crm_android/models/nav_item_model.dart';
import 'package:crm_android/models/rive_model.dart';
import 'package:crm_android/views/screens/home/widgets/animated_bar.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

Positioned bottomNavigationBar(
    BuildContext context,
    NavigationBloc navigationBloc,
    List<StateMachineController?> controllers,
    int currentIndex) {
  // Initialize riveIconInputs with the same length as bottomNavItems
  List<SMIBool?> riveIconInputs = List.filled(bottomNavItems.length, null);
  animateTheIcon(int index, NavigationBloc navigationBloc) {
    if (riveIconInputs[index] != null) {
      riveIconInputs[index]?.change(true);
      Future.delayed(const Duration(seconds: 1), () {
        riveIconInputs[index]?.change(false);
      });
    }
    // Dispatch the navigation event to change the page
    navigationBloc.add(NavigateToPage(currentIndex: index));
  }

  void riveOnInit(
      {required Artboard artboard,
      required RiveModel riveIcon,
      required int index}) {
    StateMachineController? controller = StateMachineController.fromArtboard(
      artboard,
      riveIcon.stateMachineName,
    );
    if (controller != null) {
      artboard.addController(controller);
      controllers.add(controller);
      // Make sure the right index is updated with the SMIBool input
      riveIconInputs[index] = controller.findInput<bool>("active") as SMIBool;
    }
  }

  return Positioned(
    bottom: 20, // Adjust this to move the bar up or down
    left: MediaQuery.of(context).size.width * 0.1,
    right: MediaQuery.of(context).size.width * 0.1,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(24), // Round the corners
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // Apply the blur effect
        child: Container(
          decoration: const BoxDecoration(
            color:
                Colors.transparent, // Adjust opacity for a frosted glass effect
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
                          child: RiveAnimation.asset(
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
                      // Text(bottomNavItems[index].title,style: TextStyle(color: Colors.white),)
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
