import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const iconAssetPath = "assets/icons/search.svg";

class SearchBarWidget extends StatelessWidget {

  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
          isDense: false,
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
