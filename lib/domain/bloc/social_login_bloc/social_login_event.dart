import 'package:equatable/equatable.dart';

class SocialLoginEvent extends Equatable {
  const SocialLoginEvent();

  @override
  List<Object> get props => [];
}

class SocialLoginLoadingCheckAuth extends SocialLoginEvent {
  final String message;

  const SocialLoginLoadingCheckAuth({required this.message});

  @override
  List<Object> get props => [];
}

