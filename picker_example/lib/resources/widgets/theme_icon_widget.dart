import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Lightbulb icon that shows if in dark/light mode {note: uses FontAwesome}
class ThemeIconWidget extends StatelessWidget {
  final Color dark;
  final Color light;
  final double size;

  const ThemeIconWidget({final this.dark = Colors.black54, final this.light = Colors.yellow, final this.size = 26});

  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final lightIcon = FaIcon(
      FontAwesomeIcons.lightLightbulbOn,
      size: size,
      color: light,
    );
    final darkIcon = FaIcon(
      FontAwesomeIcons.lightLightbulb,
      size: size,
      color: dark,
    );
    return isDarkTheme ? darkIcon : lightIcon;
  }
}
