import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: 26, horizontal: 32),
    ),
    alignment: Alignment.centerLeft,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.primary),
    elevation: WidgetStateProperty.resolveWith<double>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) return 1;
        return 0;
      },
    ),
  ),
);
