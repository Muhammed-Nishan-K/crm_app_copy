
part of 'navigation.bloc.dart';
@immutable
sealed class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateToPage extends NavigationEvent {
  final int currentIndex;

  NavigateToPage({required this.currentIndex});

  List<Object> get props => [currentIndex];
}