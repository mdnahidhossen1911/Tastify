import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/res/assets_path.dart';
import 'package:tastify/res/theme/theme_changer.dart';

class HomeAppLogo extends StatelessWidget {
  const HomeAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    return themeChanger.values
        ? Image.asset(AssetsPath.appLogoDarkPNG, height: 36)
        : Image.asset(AssetsPath.appLogoPNG, height: 36);
  }
}
