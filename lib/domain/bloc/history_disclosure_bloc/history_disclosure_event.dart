import 'package:equatable/equatable.dart';

abstract class HistoryDisclosureEvent extends Equatable {
  const HistoryDisclosureEvent();

  @override
  List<Object> get props => [];
}

class HistoryDisclosureButtonSave extends HistoryDisclosureEvent {
  final String selectedOption;

  const HistoryDisclosureButtonSave({required this.selectedOption});

  @override
  List<Object> get props => [];
}