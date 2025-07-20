import 'package:flutter/material.dart';


class ScreenBackground extends StatelessWidget {
  const ScreenBackground({
    super.key, required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 230, 230, 1),
                  Color.fromRGBO(255, 255, 233, 1),
                ]),
          ),

        ),
      child,
      ],
    );
  }
}


