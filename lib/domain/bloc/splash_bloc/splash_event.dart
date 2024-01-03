import 'package:equatable/equatable.dart';
import 'package:finutss/domain/controller/auth_controller.dart';

class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class SplashCheckIsFistRunApp extends SplashEvent {
  final AuthController authController;

  const SplashCheckIsFistRunApp({required this.authController});

  @override
  List<Object> get props => [];
}
