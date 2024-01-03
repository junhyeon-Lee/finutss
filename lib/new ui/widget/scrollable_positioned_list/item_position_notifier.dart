
import 'package:finutss/new%20ui/widget/scrollable_positioned_list/item_positions_listner.dart';
import 'package:flutter/material.dart';

/// Internal implementation of [ItemPositionsListener].
class ItemPositionsNotifier implements ItemPositionsListener {
  @override
  final ValueNotifier<Iterable<ItemPosition>> itemPositions = ValueNotifier([]);
}
