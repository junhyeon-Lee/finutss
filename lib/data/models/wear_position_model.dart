import 'package:get/get.dart';

class ChipsModel {
  ChipsModel({
    this.text = '',
    this.description = '',
    this.imagePath = '',
    this.isSelected,
  });

  String? text;
  String? description;
  String? imagePath;
  RxBool? isSelected;
}
