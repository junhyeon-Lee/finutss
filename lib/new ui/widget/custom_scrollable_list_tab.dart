import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/scrollable_positioned_list/custom_scrollable_positioned_list.dart';
import 'package:finutss/new%20ui/widget/scrollable_positioned_list/item_positions_listner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';
import 'package:easy_debounce/easy_debounce.dart';


typedef IndexedActiveStatusWidgetBuilder = Widget Function(
    BuildContext context, int index, bool active);
typedef IndexedVoidCallback = void Function(int index);

typedef HeaderContainerBuilder = Widget Function(
    BuildContext context, Widget child);
typedef HeaderWidgetBuilder = Widget Function(
    BuildContext context, Widget child);
typedef BodyContainerBuilder = Widget Function(
    BuildContext context, Widget child);

class CustomScrollableListTabScroller extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedActiveStatusWidgetBuilder tabBuilder;
  final HeaderContainerBuilder? headerContainerBuilder;
  final HeaderWidgetBuilder? headerWidgetBuilder;
  final BodyContainerBuilder? bodyContainerBuilder;
  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;
  final void Function(int)? tabChanged;
  final double earlyChangePositionOffset;
  final Duration animationDuration;
  final ScrollController? scrollController;

  CustomScrollableListTabScroller({
    required this.itemCount,
    required this.itemBuilder,
    required this.tabBuilder,
    this.headerContainerBuilder,
    this.headerWidgetBuilder,
    this.bodyContainerBuilder,
    this.itemScrollController,
    this.itemPositionsListener,
    this.tabChanged,
    this.earlyChangePositionOffset = 0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.shrinkWrap = false,
    this.initialScrollIndex = 0,
    this.initialAlignment = 0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.semanticChildCount,
    this.padding,
    this.addSemanticIndexes = true,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.minCacheExtent,
    this.scrollController,
  });

  /// Index of an item to initially align within the viewport.
  final int initialScrollIndex;

  /// Determines where the leading edge of the item at [initialScrollIndex]
  /// should be placed.
  ///
  /// See [ItemScrollController.jumpTo] for an explanation of alignment.
  final double initialAlignment;

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether the view scrolls in the reading direction.
  ///
  /// Defaults to false.
  ///
  /// See [ScrollView.reverse].
  final bool reverse;

  /// {@template flutter.widgets.scroll_view.shrinkWrap}
  /// Whether the extent of the scroll view in the [scrollDirection] should be
  /// determined by the contents being viewed.
  ///
  ///  Defaults to false.
  ///
  /// See [ScrollView.shrinkWrap].
  final bool shrinkWrap;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// See [ScrollView.physics].
  final ScrollPhysics? physics;

  /// The number of children that will contribute semantic information.
  ///
  /// See [ScrollView.semanticChildCount] for more information.
  final int? semanticChildCount;

  /// The amount of space by which to inset the children.
  final EdgeInsets? padding;

  /// Whether to wrap each child in an [IndexedSemantics].
  ///
  /// See [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Whether to wrap each child in an [AutomaticKeepAlive].
  ///
  /// See [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Whether to wrap each child in a [RepaintBoundary].
  ///
  /// See [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// The minimum cache extent used by the underlying scroll lists.
  /// See [ScrollView.cacheExtent].
  ///
  /// Note that the [ScrollablePositionedList] uses two lists to simulate long
  /// scrolls, so using the [ScrollController.scrollTo] method may result
  /// in builds of widgets that would otherwise already be built in the
  /// cache extent.
  final double? minCacheExtent;

  @override
  ScrollableListTabScrollerState createState() =>
      ScrollableListTabScrollerState();
}

class ScrollableListTabScrollerState extends State<CustomScrollableListTabScroller> {
  late final ItemScrollController itemScrollController;
  late final ItemPositionsListener itemPositionsListener;
  final _selectedTabIndex = ValueNotifier(0);
  final _debounceId = "scrollable_list_tab_scroller_" + Uuid().v1();
  Size _currentPositionedListSize = Size.zero;

  @override
  void initState() {
    super.initState();
    // try to use user controllers or create them
    itemScrollController =
        widget.itemScrollController ?? ItemScrollController();
    itemPositionsListener =
        widget.itemPositionsListener ?? ItemPositionsListener.create();

    itemPositionsListener.itemPositions.addListener(_itemPositionListener);

    _selectedTabIndex.addListener(() {
      EasyDebounce.debounce(_debounceId, widget.animationDuration, () {
        widget.tabChanged?.call(_selectedTabIndex.value);
      });
    });
  }

  void _triggerScrollInPositionedListIfNeeded(int index) {
    if (getDisplayedPositionFromList() != index &&
        // Prevent operation when length == 0 (Component was rendered outside screen)
        itemPositionsListener.itemPositions.value.length != 0) {
      // disableItemPositionListener = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (itemScrollController.isAttached) {
          itemScrollController.scrollTo(
              index: index, duration: widget.animationDuration);
        }
      });


    }
  }

  void setCurrentActiveIfDifferent(int currentActive) {
    if (_selectedTabIndex.value != currentActive)
      _selectedTabIndex.value = currentActive;
  }

  void _itemPositionListener() {
    // Prevent operation when length == 0 (Component was rendered outside screen)
    if (itemPositionsListener.itemPositions.value.length == 0) {
      return;
    }
    final displayedIdx = getDisplayedPositionFromList();
    if (displayedIdx != null) {
      setCurrentActiveIfDifferent(displayedIdx);
    }
  }

  int? getDisplayedPositionFromList() {
    final value = itemPositionsListener.itemPositions.value;
    if (value.length < 1) {
      return null;
    }
    final orderedListByPositionIndex = value.toList()
      ..sort((a, b) => a.index.compareTo(b.index));

    final renderedMostTopItem = orderedListByPositionIndex.first;
    if (renderedMostTopItem.getBottomOffset(_currentPositionedListSize) <
        widget.earlyChangePositionOffset) {
      if (orderedListByPositionIndex.length > 1) {
        return orderedListByPositionIndex[1].index;
      }
    }
    return renderedMostTopItem.index;
  }

  Widget buildCustomHeaderContainerOrDefault(
      {required BuildContext context, required Widget child}) {
    return widget.headerContainerBuilder?.call(context, child) ??
        SizedBox(
          height: 40.h,
          child: Center(child: child),
        );
  }

  Widget buildCustomBodyContainerOrDefault(
      {required BuildContext context, required Widget child}) {
    return widget.bodyContainerBuilder?.call(context, child) ??
        Expanded(
          child: child,
        );
  }

  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    itemScrollController.scrollTo(
        index: 0, duration: event.duration, curve: event.curve);
  }

  @override
  void dispose() {
    EasyDebounce.cancel(_debounceId);
    itemPositionsListener.itemPositions.removeListener(_itemPositionListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCustomHeaderContainerOrDefault(
          context: context,
          child: DefaultHeaderWidget(
            key: Key(widget.itemCount.toString()),
            itemCount: widget.itemCount,
            onTapTab: (i) => _triggerScrollInPositionedListIfNeeded(i),
            //TODO: implement callback to handle tab click ,
            selectedTabIndex: _selectedTabIndex,
            tabBuilder: widget.tabBuilder,
          ),
        ),
        buildCustomBodyContainerOrDefault(
          context: context,
          child: Builder(builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              final size = context.size;
              if (size != null) {
                _currentPositionedListSize = size;
              }
            });
            return ScrollsToTop(
              onScrollsToTop: _onScrollsToTop,
              child: CustomScrollablePositionedList.builder(
                itemBuilder: (a, b) {
                  return widget.itemBuilder(a, b);
                },
                scrollController: widget.scrollController,
                itemCount: widget.itemCount,
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                shrinkWrap: widget.shrinkWrap,
                initialScrollIndex: widget.initialScrollIndex,
                initialAlignment: widget.initialAlignment,
                scrollDirection: widget.scrollDirection,
                reverse: widget.reverse,
                physics: widget.physics,
                semanticChildCount: widget.semanticChildCount,
                padding: widget.padding,
                addSemanticIndexes: widget.addSemanticIndexes,
                addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                addRepaintBoundaries: widget.addRepaintBoundaries,
                minCacheExtent: widget.minCacheExtent,
              ),
            );
          }),
        )
      ],
    );
  }
}

class DefaultHeaderWidget extends StatefulWidget {
  final ValueNotifier<int> selectedTabIndex;
  final IndexedActiveStatusWidgetBuilder tabBuilder;
  final IndexedVoidCallback onTapTab;
  final int itemCount;

  DefaultHeaderWidget({
    Key? key,
    required this.selectedTabIndex,
    required this.tabBuilder,
    required this.onTapTab,
    required this.itemCount,
  }) : super(key: key);

  @override
  State<DefaultHeaderWidget> createState() => _DefaultHeaderWidgetState();
}

class _DefaultHeaderWidgetState extends State<DefaultHeaderWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.selectedTabIndex.value,
      length: widget.itemCount,
      vsync: this,
    );
    _tabController.addListener(tabChangeListener);
    widget.selectedTabIndex.addListener(externalTabChangeListener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    widget.selectedTabIndex.removeListener(externalTabChangeListener);
    super.dispose();
  }

  void tabChangeListener() {
    widget.onTapTab(_tabController.index);
  }

  void externalTabChangeListener() {
    _tabController.index = widget.selectedTabIndex.value;
  }

  void _onTapTab(_) {
    _tabController.index = widget.selectedTabIndex.value;
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final tabList = List.generate(
      widget.itemCount,
          (i) => ValueListenableBuilder(
        valueListenable: widget.selectedTabIndex,
        builder: (context, selectedIndex, child) =>
            widget.tabBuilder(context, i, i == selectedIndex),
      ),
    );
    return Container(
      color: AppColor.whiteColor,
      child: Center(
        child: TabBar(
          onTap: _onTapTab,
          indicator: BoxDecoration(),
          indicatorWeight: 0,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
          automaticIndicatorColorAdjustment: false,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          labelColor: defaultTextStyle.style.color,
          isScrollable: true,
          controller: _tabController,
          tabs: tabList,
        ),
      ),
    );
  }
}

// Utils

extension _ItemPositionUtilsExtension on ItemPosition {
  double getBottomOffset(Size size) {
    return itemTrailingEdge * size.height;
  }
}