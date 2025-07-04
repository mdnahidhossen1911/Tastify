import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AssetsPath.appLogoPNG, height: 60, width: 210),

    );
  }
}