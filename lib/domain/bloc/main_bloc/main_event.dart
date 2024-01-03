import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainEventCheckTapButtonNavigationBarByIndex extends MainEvent {
  final int index;

  MainEventCheckTapButtonNavigationBarByIndex({required this.index});

  @override
  List<Object> get props => [];
}







