import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const iconAssetPath = "assets/icons/search.svg";

class SearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Buscar Ativo ou Local",
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          prefixIcon: SvgPicture.asset(
            iconAssetPath,
            width: 12.5,
            height: 12.5,
            fit: BoxFit.scaleDown,
          ),
        ),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
