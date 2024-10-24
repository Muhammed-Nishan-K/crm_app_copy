part of 'navigation.bloc.dart';


@immutable
sealed class NavigationState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class NavigationInitial extends NavigationState {
}

final class NavigationChanged extends NavigationState {
  final int currentIndex;

  NavigationChanged({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}