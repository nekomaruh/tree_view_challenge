import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

const radius = 4.0;

final inputDecorationTheme = InputDecorationTheme(
  filled: true,
  isDense: true,
  fillColor: AppColors.filled,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide.none,
    /*
    borderSide: const BorderSide(
      color: borderColor,
      width: 2.0,
    ),*/
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide.none,
  ),
  labelStyle: const TextStyle(
    color: AppColors.primary,
    fontSize: 16.0,
  ),
  hintStyle: const TextStyle(
    color: AppColors.inactive,
  ),
);
