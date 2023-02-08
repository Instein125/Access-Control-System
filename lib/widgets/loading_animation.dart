import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(150),
      child: LoadingIndicator(
        indicatorType: Indicator.ballBeat,

        /// Required, The loading type of the widget
        colors: [
          Color.fromARGB(255, 219, 155, 81),
          Color.fromARGB(255, 73, 162, 83),
          Color.fromARGB(255, 209, 100, 92)
        ],

        /// Optional, The color collections
        strokeWidth: 1,
      ),
    );
  }
}
