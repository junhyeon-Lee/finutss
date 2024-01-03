import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashStateInitialState extends SplashState {
  const SplashStateInitialState();

  @override
  List<Object> get props => [];
}

class SplashStateIsFistRunAppSignInScreen extends SplashState {
  const SplashStateIsFistRunAppSignInScreen();

  @override
  List<Object> get props => [];
}

class SplashStateIsFistRunAppPermissionsInfoScreen extends SplashState {
  const SplashStateIsFistRunAppPermissionsInfoScreen();

  @override
  List<Object> get props => [];
}

class SplashStateIsNotFistRunAppSignInScreen extends SplashState {
  final String token;
  final int accessTokenExpiresAt;
  final String refreshToken;
  final int refreshTokenExpiresAt;

  const SplashStateIsNotFistRunAppSignInScreen({required this.token, required this.accessTokenExpiresAt, required this.refreshToken, required this.refreshTokenExpiresAt});

  @override
  List<Object> get props => [];
}

class SplashStateIsNotFistRunAppMainPage extends SplashState {
  final String token;
  final int accessTokenExpiresAt;
  final String refreshToken;
  final int refreshTokenExpiresAt;

  const SplashStateIsNotFistRunAppMainPage({required this.token, required this.accessTokenExpiresAt, required this.refreshToken, required this.refreshTokenExpiresAt});

  @override
  List<Object> get props => [];
}
