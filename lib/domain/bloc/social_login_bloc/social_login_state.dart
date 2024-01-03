import 'package:equatable/equatable.dart';

class SocialLoginState extends Equatable {
  const SocialLoginState();

  @override
  List<Object> get props => [];
}

class SocialLoginInitialState extends SocialLoginState  {

  SocialLoginInitialState();

  @override
  List<Object> get props => [];
}

class SocialLoadingAuth extends SocialLoginState  {
  final String url;

  SocialLoadingAuth({required this.url});

  @override
  List<Object> get props => [];
}
