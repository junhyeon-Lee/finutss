import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircleSliderModel {
  final List<Color> pageColors;
  final CircularSliderAppearance appearance;
  final double min;
  final double max;
  final double value;
  final InnerWidget? innerWidget;

  CircleSliderModel(
      {required this.pageColors,
        required this.appearance,
        this.min = 0,
        this.max = 100,
        this.value = 50,
        this.innerWidget});
}

class ExamplePage extends StatelessWidget {
  final CircleSliderModel viewModel;
  const ExamplePage({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 150,
        width: 150,

        child: SafeArea(
          child: Center(
              child: SleekCircularSlider(
                onChangeStart: (double value) {},
                onChangeEnd: (double value) {},
                innerWidget: viewModel.innerWidget,
                appearance: viewModel.appearance,
                min: viewModel.min,
                max: viewModel.max,
                initialValue: viewModel.value,
              )),
        ),
      ),
    );
  }
}