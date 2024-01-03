import 'package:get/get.dart';

class ExerciserModel {
  final String topPrefixIcon;
  final String mainIcon;
  final String title;
  final String description;
  RxBool isSelected = false.obs;

  ExerciserModel({
    required this.topPrefixIcon,
    required this.mainIcon,
    required this.title,
    required this.description,
    required this.isSelected,
  });
}
