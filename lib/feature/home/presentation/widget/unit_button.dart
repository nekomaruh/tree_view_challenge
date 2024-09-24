import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _unitIconPath = "assets/icons/unit.svg";

class UnitButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const UnitButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(317, 76),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            _unitIconPath,
          ),
          const SizedBox(width: 16),
          Text("$text Unit")
        ],
      ),
    );
  }
}
