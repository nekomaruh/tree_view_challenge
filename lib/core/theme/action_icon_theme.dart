import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final actionIconTheme = ActionIconThemeData(
  backButtonIconBuilder: (BuildContext context) =>
      SvgPicture.asset('assets/icons/back.svg', width: 24, height: 24,),
);
