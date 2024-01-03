import 'package:finutss/new%20ui/modules/store/model/detail_model.dart';
import 'package:flutter/cupertino.dart';

class StoreModel {
  String title;
  String amount;
  String description;
  String totalMonth;
  String discount;
  List<DetailModel> itemList;
  String btnTitle;
  String purchaseId;

  StoreModel(this.title, this.amount, this.description, this.totalMonth, this.discount, this.itemList, this.btnTitle, this.purchaseId);
}
