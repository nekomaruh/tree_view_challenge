import 'package:flutter/material.dart';
import 'package:tree_view_challenge/core/theme/app_bar_theme.dart';
import 'package:tree_view_challenge/core/theme/divider_theme.dart';
import 'package:tree_view_challenge/core/theme/elevated_button_theme.dart';

import 'colors/app_colors.dart';
import 'input_decoration_theme.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: false,
  scaffoldBackgroundColor: AppColors.white,
  inputDecorationTheme: inputDecorationTheme,
  appBarTheme: appBarTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  dividerTheme: dividerTheme
);
