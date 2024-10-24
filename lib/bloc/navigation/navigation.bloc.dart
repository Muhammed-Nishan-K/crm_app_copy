import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'navigation.event.dart';
part 'navigation.state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigateToPage>((event,emit){
      emit(NavigationChanged(currentIndex: event.currentIndex));
    });
  }
}
